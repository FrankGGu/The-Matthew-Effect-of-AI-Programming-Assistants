#include <stdlib.h> // For malloc, free, strdup
#include <string.h> // For strcmp, strlen
#include <stdio.h>  // For sprintf
#include <stdbool.h> // For bool
#include <limits.h> // For INT_MAX

#define HASH_MAP_CAPACITY 2003 // A prime number for hash map size

typedef struct HashMapEntry {
    char* key;
    void* value;
    struct HashMapEntry* next;
} HashMapEntry;

typedef struct HashMap {
    HashMapEntry** buckets;
    int capacity;
    int size;
} HashMap;

unsigned int hash_string(const char* str, int capacity) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    return hash % capacity;
}

HashMap* hm_create(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->buckets = (HashMapEntry**)calloc(capacity, sizeof(HashMapEntry*));
    return map;
}

void hm_put(HashMap* map, const char* key, void* value) {
    unsigned int index = hash_string(key, map->capacity);
    HashMapEntry* entry = map->buckets[index];

    while (entry != NULL) {
        if (strcmp(entry->key, key) == 0) {
            entry->value = value; // Update existing value
            return;
        }
        entry = entry->next;
    }

    // Add new entry
    HashMapEntry* new_entry = (HashMapEntry*)malloc(sizeof(HashMapEntry));
    new_entry->key = strdup(key); // Copy key
    new_entry->value = value;
    new_entry->next = map->buckets[index];
    map->buckets[index] = new_entry;
    map->size++;
}

void* hm_get(HashMap* map, const char* key) {
    unsigned int index = hash_string(key, map->capacity);
    HashMapEntry* entry = map->buckets[index];

    while (entry != NULL) {
        if (strcmp(entry->key, key) == 0) {
            return entry->value;
        }
        entry = entry->next;
    }
    return NULL; // Not found
}

void hm_remove(HashMap* map, const char* key) {
    unsigned int index = hash_string(key, map->capacity);
    HashMapEntry* entry = map->buckets[index];
    HashMapEntry* prev = NULL;

    while (entry != NULL) {
        if (strcmp(entry->key, key) == 0) {
            if (prev == NULL) {
                map->buckets[index] = entry->next;
            } else {
                prev->next = entry->next;
            }
            free(entry->key); // Free copied key
            free(entry);
            map->size--;
            return;
        }
        prev = entry;
        entry = entry->next;
    }
}

void hm_free(HashMap* map) {
    for (int i = 0; i < map->capacity; i++) {
        HashMapEntry* entry = map->buckets[i];
        while (entry != NULL) {
            HashMapEntry* temp = entry;
            entry = entry->next;
            free(temp->key);
            // The value is owned by other data structures and freed elsewhere.
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

typedef struct StringNode {
    char* key; // The actual key string
    struct StringNode* prev;
    struct StringNode* next;
    struct CountNode* parent_count_node; // Pointer back to the CountNode it belongs to
} StringNode;

typedef struct StringList {
    StringNode* head; // Sentinel head
    StringNode* tail; // Sentinel tail
    int size;
} StringList;

StringList* sl_create() {
    StringList* list = (StringList*)malloc(sizeof(StringList));
    list->head = (StringNode*)malloc(sizeof(StringNode)); // Sentinel head
    list->tail = (StringNode*)malloc(sizeof(StringNode)); // Sentinel tail
    list->head->prev = NULL;
    list->head->next = list->tail;
    list->tail->prev = list->head;
    list->tail->next = NULL;
    list->size = 0;
    return list;
}

void sl_add_to_tail(StringList* list, StringNode* node) {
    node->prev = list->tail->prev;
    node->next = list->tail;
    list->tail->prev->next = node;
    list->tail->prev = node;
    list->size++;
}

void sl_remove(StringList* list, StringNode* node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
    list->size--;
}

bool sl_is_empty(StringList* list) {
    return list->size == 0;
}

void sl_free(StringList* list) {
    free(list->head);
    free(list->tail);
    free(list);
}

typedef struct CountNode {
    int count;
    StringList* keys; // List of StringNodes (keys) that have this count
    struct CountNode* prev;
    struct CountNode* next;
} CountNode;

typedef struct AllOne {
    CountNode* head; // Sentinel head for the CountNode list (count 0)
    CountNode* tail; // Sentinel tail for the CountNode list (count infinity)
    HashMap* key_to_string_node_map; // char* key -> StringNode*
    HashMap* count_to_count_node_map; // char* (int) count -> CountNode*
} AllOne;

static char itoa_buffer[32];
char* int_to_string(int num) {
    sprintf(itoa_buffer, "%d", num);
    return itoa_buffer;
}

AllOne* allOneCreate() {
    AllOne* obj = (AllOne*)malloc(sizeof(AllOne));

    obj->head = (CountNode*)malloc(sizeof(CountNode));
    obj->tail = (CountNode*)malloc(sizeof(CountNode));

    obj->head->count = 0; // Sentinel
    obj->head->keys = NULL;
    obj->head->prev = NULL;
    obj->head->next = obj->tail;

    obj->tail->count = INT_MAX; // Sentinel
    obj->tail->keys = NULL;
    obj->tail->prev = obj->head;
    obj->tail->next = NULL;

    obj->key_to_string_node_map = hm_create(HASH_MAP_CAPACITY);
    obj->count_to_count_node_map = hm_create(HASH_MAP_CAPACITY);

    return obj;
}

void allOneInc(AllOne* obj, char* key) {
    StringNode* old_string_node = (StringNode*)hm_get(obj->key_to_string_node_map, key);
    CountNode* old_count_node = NULL;
    int old_count = 0;

    if (old_string_node != NULL) {
        old_count_node = old_string_node->parent_count_node;
        old_count = old_count_node->count;

        sl_remove(old_count_node->keys, old_string_node);

        if (sl_is_empty(old_count_node->keys)) {
            // Remove old_count_node from the CountNode list
            old_count_node->prev->next = old_count_node->next;
            old_count_node->next->prev = old_count_node->prev;
            hm_remove(obj->count_to_count_node_map, int_to_string(old_count));
            sl_free(old_count_node->keys); // Free StringList structure
            free(old_count_node);          // Free CountNode structure
        }
    }

    int new_count = old_count + 1;
    CountNode* new_count_node = (CountNode*)hm_get(obj->count_to_count_node_map, int_to_string(new_count));

    if (new_count_node == NULL) {
        new_count_node = (CountNode*)malloc(sizeof(CountNode));
        new_count_node->count = new_count;
        new_count_node->keys = sl_create();

        // Insert new_count_node into the sorted CountNode list
        CountNode* insert_before_node = obj->head->next;
        while (insert_before_node != obj->tail && insert_before_node->count < new_count) {
            insert_before_node = insert_before_node->next;
        }
        new_count_node->next = insert_before_node;
        new_count_node->prev = insert_before_node->prev;
        insert_before_node->prev->next = new_count_node;
        insert_before_node->prev = new_count_node;

        hm_put(obj->count_to_count_node_map, int_to_string(new_count), new_count_node);
    }

    // Create or reuse StringNode and add to new_count_node's list
    StringNode* new_string_node;
    if (old_string_node != NULL) {
        new_string_node = old_string_node; // Reuse existing StringNode
    } else {
        new_string_node = (StringNode*)malloc(sizeof(StringNode));
        new_string_node->key = strdup(key); // New key, so allocate string
    }
    new_string_node->parent_count_node = new_count_node;
    sl_add_to_tail(new_count_node->keys, new_string_node);

    hm_put(obj->key_to_string_node_map, key, new_string_node);
}

void allOneDec(AllOne* obj, char* key) {
    StringNode* old_string_node = (StringNode*)hm_get(obj->key_to_string_node_map, key);
    if (old_string_node == NULL) {
        return; // Key does not exist, problem guarantees key exists.
    }

    CountNode* old_count_node = old_string_node->parent_count_node;
    int old_count = old_count_node->count;

    sl_remove(old_count_node->keys, old_string_node);

    // Remove key from key_to_string_node_map and free StringNode
    hm_remove(obj->key_to_string_node_map, key);
    free(old_string_node->key); // Free the string owned by StringNode
    free(old_string_node);      // Free the StringNode itself

    if (sl_is_empty(old_count_node->keys)) {
        // Remove old_count_node from the CountNode list
        old_count_node->prev->next = old_count_node->next;
        old_count_node->next->prev = old_count_node->prev;
        hm_remove(obj->count_to_count_node_map, int_to_string(old_count));
        sl_free(old_count_node->keys); // Free StringList structure
        free(old_count_node);          // Free CountNode structure
    }

    int new_count = old_count - 1;

    if (new_count == 0) {
        return; // Key is effectively removed from the data structure
    }

    CountNode* new_count_node = (CountNode*)hm_get(obj->count_to_count_node_map, int_to_string(new_count));

    if (new_count_node == NULL) {
        new_count_node = (CountNode*)malloc(sizeof(CountNode));
        new_count_node->count = new_count;
        new_count_node->keys = sl_create();

        // Insert new_count_node into the sorted CountNode list
        CountNode* insert_before_node = obj->head->next;
        while (insert_before_node != obj->tail && insert_before_node->count < new_count) {
            insert_before_node = insert_before_node->next;
        }
        new_count_node->next = insert_before_node;
        new_count_node->prev = insert_before_node->prev;
        insert_before_node->prev->next = new_count_node;
        insert_before_node->prev = new_count_node;

        hm_put(obj->count_to_count_node_map, int_to_string(new_count), new_count_node);
    }

    // Create new StringNode for the key and add to new_count_node's list
    StringNode* new_string_node = (StringNode*)malloc(sizeof(StringNode));
    new_string_node->key = strdup(key);
    new_string_node->parent_count_node = new_count_node;
    sl_add_to_tail(new_count_node->keys, new_string_node);

    hm_put(obj->key_to_string_node_map, key, new_string_node);
}

char* allOneGetMaxKey(AllOne* obj) {
    if (obj->tail->prev == obj->head) { // List is empty
        return "";
    }
    CountNode* max_count_node = obj->tail->prev;
    return max_count_node->keys->head->next->key; // Return first key in the list
}

char* allOneGetMinKey(AllOne* obj) {
    if (obj->head->next == obj->tail) { // List is empty
        return "";
    }
    CountNode* min_count_node = obj->head->next;
    return min_count_node->keys->head->next->key; // Return first key in the list
}

void allOneFree(AllOne* obj) {
    // 1. Free all StringNodes and their string keys
    // Iterate through the key_to_string_node_map to get all StringNode pointers
    for (int i = 0; i < obj->key_to_string_node_map->capacity; i++) {
        HashMapEntry* entry = obj->key_to_string_node_map->buckets[i];
        while (entry != NULL) {
            StringNode* sn = (StringNode*)entry->value;
            free(sn->key); // Free the string owned by StringNode
            free(sn);      // Free the StringNode struct itself
            entry = entry->next;
        }
    }
    // 2. Free the key_to_string_node_map structure (HashMapEntry structs and their keys)
    hm_free(obj->key_to_string_node_map);

    // 3. Free the count_to_count_node_map structure (HashMapEntry structs and their keys)
    hm_free(obj->count_to_count_node_map); // This frees the char* keys (e.g., "1", "2")

    // 4. Free all CountNodes and their StringList sentinels
    CountNode* current = obj->head;
    while (current != NULL) {
        CountNode* next = current->next;
        if (current->keys != NULL) { // Only non-sentinel CountNodes have StringLists
            sl_free(current->keys); // Free StringList structure and its sentinels
        }
        free(current); // Free the CountNode itself
        current = next;
    }

    // 5. Free the AllOne object
    free(obj);
}