#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset

#define HASH_TABLE_SIZE 16384

typedef struct Node {
    int key;
    int value;
    int freq;
    struct Node *prev;
    struct Node *next;
} Node;

typedef struct FreqList {
    int freq;
    Node *head;
    Node *tail;
    int size; // Number of nodes in this list
} FreqList;

typedef struct KeyMapEntry {
    int key;
    Node* node;
    struct KeyMapEntry* next;
} KeyMapEntry;

typedef struct FreqMapEntry {
    int freq;
    FreqList* list;
    struct FreqMapEntry* next;
} FreqMapEntry;

typedef struct LFUCache {
    int capacity;
    int size; // Current number of items in the cache
    int min_freq;

    // Custom hash maps using separate chaining
    KeyMapEntry* key_to_node_map[HASH_TABLE_SIZE];   // Maps key -> Node*
    FreqMapEntry* freq_to_list_map[HASH_TABLE_SIZE]; // Maps freq -> FreqList*
} LFUCache;

static inline unsigned int hash_int(int val) {
    return (unsigned int)val % HASH_TABLE_SIZE;
}

Node* key_map_get(LFUCache* obj, int key) {
    unsigned int idx = hash_int(key);
    KeyMapEntry* entry = obj->key_to_node_map[idx];
    while (entry) {
        if (entry->key == key) {
            return entry->node;
        }
        entry = entry->next;
    }
    return NULL;
}

void key_map_put(LFUCache* obj, int key, Node* node) {
    unsigned int idx = hash_int(key);
    KeyMapEntry* entry = obj->key_to_node_map[idx];
    while (entry) { // Update if key exists
        if (entry->key == key) {
            entry->node = node;
            return;
        }
        entry = entry->next;
    }
    // Add new entry
    KeyMapEntry* new_entry = (KeyMapEntry*)malloc(sizeof(KeyMapEntry));
    new_entry->key = key;
    new_entry->node = node;
    new_entry->next = obj->key_to_node_map[idx];
    obj->key_to_node_map[idx] = new_entry;
}

void key_map_delete(LFUCache* obj, int key) {
    unsigned int idx = hash_int(key);
    KeyMapEntry* entry = obj->key_to_node_map[idx];
    KeyMapEntry* prev = NULL;
    while (entry) {
        if (entry->key == key) {
            if (prev) {
                prev->next = entry->next;
            } else {
                obj->key_to_node_map[idx] = entry->next;
            }
            free(entry);
            return;
        }
        prev = entry;
        entry = entry->next;
    }
}

FreqList* freq_map_get(LFUCache* obj, int freq) {
    unsigned int idx = hash_int(freq);
    FreqMapEntry* entry = obj->freq_to_list_map[idx];
    while (entry) {
        if (entry->freq == freq) {
            return entry->list;
        }
        entry = entry->next;
    }
    return NULL;
}

void freq_map_put(LFUCache* obj, int freq, FreqList* list) {
    unsigned int idx = hash_int(freq);
    FreqMapEntry* entry = obj->freq_to_list_map[idx];
    while (entry) { // Update if freq exists
        if (entry->freq == freq) {
            entry->list = list;
            return;
        }
        entry = entry->next;
    }
    // Add new entry
    FreqMapEntry* new_entry = (FreqMapEntry*)malloc(sizeof(FreqMapEntry));
    new_entry->freq = freq;
    new_entry->list = list;
    new_entry->next = obj->freq_to_list_map[idx];
    obj->freq_to_list_map[idx] = new_entry;
}

void freq_map_delete(LFUCache* obj, int freq) {
    unsigned int idx = hash_int(freq);
    FreqMapEntry* entry = obj->freq_to_list_map[idx];
    FreqMapEntry* prev = NULL;
    while (entry) {
        if (entry->freq == freq) {
            if (prev) {
                prev->next = entry->next;
            } else {
                obj->freq_to_list_map[idx] = entry->next;
            }
            free(entry);
            return;
        }
        prev = entry;
        entry = entry->next;
    }
}

void _add_node_to_head(FreqList *list, Node *node) {
    if (!list->head) { // List is empty
        list->head = node;
        list->tail = node;
        node->prev = NULL;
        node->next = NULL;
    } else {
        node->next = list->head;
        list->head->prev = node;
        node->prev = NULL;
        list->head = node;
    }
    list->size++;
}

void _remove_node(FreqList *list, Node *node) {
    if (node->prev) {
        node->prev->next = node->next;
    } else { // Node is the head
        list->head = node->next;
    }

    if (node->next) {
        node->next->prev = node->prev;
    } else { // Node is the tail
        list->tail = node->prev;
    }
    node->prev = NULL;
    node->next = NULL;
    list->size--;
}

FreqList* _get_or_create_freq_list(LFUCache* obj, int freq) {
    FreqList *list = freq_map_get(obj, freq);
    if (!list) {
        list = (FreqList*)malloc(sizeof(FreqList));
        list->freq = freq;
        list->head = NULL;
        list->tail = NULL;
        list->size = 0;
        freq_map_put(obj, freq, list);
    }
    return list;
}

void _update_node_frequency(LFUCache* obj, Node* node) {
    // 1. Remove node from its current frequency list
    FreqList *old_freq_list = freq_map_get(obj, node->freq);
    _remove_node(old_freq_list, node);

    // 2. If the old frequency list is now empty and it was the min_freq, increment min_freq
    if (old_freq_list->size == 0) {
        freq_map_delete(obj, old_freq_list->freq);
        free(old_freq_list);
        if (obj->min_freq == node->freq) {
            obj->min_freq++;
        }
    }

    // 3. Increment node's frequency
    node->freq++;

    // 4. Add node to the head of the new frequency list
    FreqList *new_freq_list = _get_or_create_freq_list(obj, node->freq);
    _add_node_to_head(new_freq_list, node);
}

LFUCache* lFUCacheCreate(int capacity) {
    LFUCache* obj = (LFUCache*)malloc(sizeof(LFUCache));
    obj->capacity = capacity;
    obj->size = 0;
    obj->min_freq = 0;

    // Initialize hash map arrays to NULL
    memset(obj->key_to_node_map, 0, sizeof(obj->key_to_node_map));
    memset(obj->freq_to_list_map, 0, sizeof(obj->freq_to_list_map));

    return obj;
}

int lFUCacheGet(LFUCache* obj, int key) {
    if (obj->capacity == 0) {
        return -1;
    }

    Node *node = key_map_get(obj, key);

    if (!node) {
        return -1; // Key not found
    }

    // Update frequency and move node
    _update_node_frequency(obj, node);

    return node->value;
}

void lFUCachePut(LFUCache* obj, int key, int value) {
    if (obj->capacity == 0) {
        return;
    }

    Node *node = key_map_get(obj, key);

    if (node) { // Key already exists, update value and frequency
        node->value = value;
        _update_node_frequency(obj, node);
    } else { // New key
        if (obj->size == obj->capacity) {
            // Evict LFU item: get the tail (LRU) of the min_freq list
            FreqList *min_freq_list = freq_map_get(obj, obj->min_freq);

            Node *node_to_evict = min_freq_list->tail;

            // Remove from key_to_node_map
            key_map_delete(obj, node_to_evict->key);

            // Remove from its FreqList
            _remove_node(min_freq_list, node_to_evict);

            // Free the evicted node
            free(node_to_evict);

            obj->size--;

            // If min_freq_list is now empty, delete it from the map and free it
            if (min_freq_list->size == 0) {
                freq_map_delete(obj, min_freq_list->freq);
                free(min_freq_list);
                // min_freq will be reset to 1 below when the new node is added
            }
        }

        // Create new node
        Node *new_node = (Node*)malloc(sizeof(Node));
        new_node->key = key;
        new_node->value = value;
        new_node->freq = 1; // New nodes always start with frequency 1
        new_node->prev = NULL;
        new_node->next = NULL;

        // Add to key_to_node_map
        key_map_put(obj, key, new_node);

        // Add to freq 1 list
        FreqList *freq_1_list = _get_or_create_freq_list(obj, 1);
        _add_node_to_head(freq_1_list, new_node);

        obj->min_freq = 1; // New node means min_freq is now 1
        obj->size++;
    }
}

void lFUCacheFree(LFUCache* obj) {
    // Free all nodes and their KeyMapEntry wrappers
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        KeyMapEntry* entry = obj->key_to_node_map[i];
        while (entry) {
            KeyMapEntry* temp = entry;
            entry = entry->next;
            free(temp->node); // Free the actual Node
            free(temp);      // Free the hash map entry wrapper
        }
    }

    // Free all FreqList structures and their FreqMapEntry wrappers
    for (int i = 0; i < HASH_TABLE_SIZE; i++) {
        FreqMapEntry* entry = obj->freq_to_list_map[i];
        while (entry) {
            FreqMapEntry* temp = entry;
            entry = entry->next;
            free(temp->list); // Free the actual FreqList
            free(temp);       // Free the hash map entry wrapper
        }
    }
    free(obj);
}