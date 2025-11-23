#include <stdlib.h>
#include <stdbool.h>
#include <time.h> // For srand

typedef struct HashNode {
    int key;    // The actual value stored in RandomizedSet
    int val;    // Its index in the RandomizedSet's array
    struct HashNode *next;
} HashNode;

typedef struct HashMap {
    HashNode **buckets;
    int num_buckets;
    int size; // Number of elements in the hash map
} HashMap;

static int hash(int key, int num_buckets) {
    // Handle negative keys by ensuring the result is non-negative
    return (key % num_buckets + num_buckets) % num_buckets;
}

static HashMap* createHashMap(int num_buckets) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->num_buckets = num_buckets;
    map->size = 0;
    map->buckets = (HashNode**)calloc(num_buckets, sizeof(HashNode*)); // Initialize all buckets to NULL
    return map;
}

static bool insertHashMap(HashMap *map, int key, int val) {
    int index = hash(key, map->num_buckets);
    HashNode *current = map->buckets[index];

    // Check if key already exists
    while (current != NULL) {
        if (current->key == key) {
            current->val = val; // Update value
            return false; // Key already existed
        }
        current = current->next;
    }

    // Key does not exist, insert new node at the head of the list
    HashNode *newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->val = val;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
    map->size++;
    return true; // New key inserted
}

static HashNode* getHashMapNode(HashMap *map, int key) {
    int index = hash(key, map->num_buckets);
    HashNode *current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            return current;
        }
        current = current->next;
    }
    return NULL; // Key not found
}

static bool removeHashMap(HashMap *map, int key) {
    int index = hash(key, map->num_buckets);
    HashNode *current = map->buckets[index];
    HashNode *prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) { // Node to be removed is the head
                map->buckets[index] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            map->size--;
            return true; // Key found and removed
        }
        prev = current;
        current = current->next;
    }
    return false; // Key not found
}

static void freeHashMap(HashMap *map) {
    if (!map) return;
    for (int i = 0; i < map->num_buckets; i++) {
        HashNode *current = map->buckets[i];
        while (current != NULL) {
            HashNode *temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

typedef struct {
    int *arr;
    int size;     // Current number of elements
    int capacity; // Current allocated capacity for arr
    HashMap *map; // Stores value -> index in arr
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet *obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->size = 0;
    obj->capacity = 16; // Initial capacity, will grow dynamically
    obj->arr = (int*)malloc(sizeof(int) * obj->capacity);
    // A reasonable number of buckets for the hash map, considering max operations 2*10^5
    obj->map = createHashMap(20000); 
    srand(time(NULL)); // Seed random number generator once
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (getHashMapNode(obj->map, val) != NULL) {
        return false; // Value already exists
    }

    // If array is full, reallocate
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->arr = (int*)realloc(obj->arr, sizeof(int) * obj->capacity);
    }

    // Add value to the end of the array
    obj->arr[obj->size] = val;
    // Store value -> its index in the hash map
    insertHashMap(obj->map, val, obj->size);
    obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    HashNode *node = getHashMapNode(obj->map, val);
    if (node == NULL) {
        return false; // Value not present
    }

    int index_to_remove = node->val; // Get index of val in the array
    int last_element_val = obj->arr[obj->size - 1]; // Get the last element in the array

    // Move the last element to the position of the element to be removed
    // This handles the case where val IS the last element too (it moves itself)
    obj->arr[index_to_remove] = last_element_val;

    // Update the hash map for the moved element (last_element_val)
    // Its new index is index_to_remove
    insertHashMap(obj->map, last_element_val, index_to_remove);

    // Remove the original value from the hash map
    removeHashMap(obj->map, val);

    // Decrease the size of the array
    obj->size--;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    int random_index = rand() % obj->size;
    return obj->arr[random_index];
}

void randomizedSetFree(RandomizedSet* obj) {
    if (!obj) return;
    free(obj->arr);
    freeHashMap(obj->map);
    free(obj);
}