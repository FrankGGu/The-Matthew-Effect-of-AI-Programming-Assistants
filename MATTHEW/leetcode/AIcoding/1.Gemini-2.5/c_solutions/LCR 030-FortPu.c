#include <stdlib.h> // For malloc, free, rand, srand, realloc
#include <stdbool.h> // For bool
#include <time.h>    // For time (to seed rand)

typedef enum {
    HASH_EMPTY,
    HASH_OCCUPIED,
    HASH_DELETED
} HashStatus;

typedef struct {
    int* arr;         // Dynamic array to store elements
    int size;         // Current number of elements in arr
    int capacity;     // Allocated capacity of arr

    // Custom Hash Map (Open Addressing with Linear Probing)
    // Stores val -> index_in_arr mapping
    int* map_keys;       // Stores the values (keys of the map)
    int* map_values;     // Stores the indices (values of the map)
    HashStatus* map_status; // Status of each slot: EMPTY, OCCUPIED, DELETED
    int map_capacity;    // Size of the hash table array
    int map_count;       // Number of elements currently in the hash table (OCCUPIED slots)
    int map_deleted_count; // Number of DELETED slots
} RandomizedSet;

static void _randomizedSet_resize_map(RandomizedSet* obj);

static inline int get_hash(int val, int capacity) {
    long long h = val; // Use long long to handle INT_MIN correctly
    h = h % capacity;
    if (h < 0) { // Ensure positive hash for negative numbers
        h += capacity;
    }
    return (int)h;
}

static int _randomizedSet_find_map_slot(RandomizedSet* obj, int val, int* insert_idx_ptr) {
    int initial_idx = get_hash(val, obj->map_capacity);
    int idx = initial_idx;
    int first_deleted_idx = -1;

    // Probe until an EMPTY slot is found
    while (obj->map_status[idx] != HASH_EMPTY) {
        if (obj->map_status[idx] == HASH_OCCUPIED && obj->map_keys[idx] == val) {
            return idx; // Value found
        }
        if (obj->map_status[idx] == HASH_DELETED && first_deleted_idx == -1) {
            first_deleted_idx = idx; // Remember the first deleted slot encountered
        }
        idx = (idx + 1) % obj->map_capacity;
        if (idx == initial_idx) break; // Full circle, map is full or logic error (should not happen with proper resizing)
    }

    // If value not found, return the best insertion point
    if (insert_idx_ptr) {
        *insert_idx_ptr = (first_deleted_idx != -1) ? first_deleted_idx : idx;
    }
    return -1; // Value not found
}

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    if (!obj) return NULL;

    // Initialize dynamic array
    obj->capacity = 16; // Initial capacity for the elements array
    obj->arr = (int*)malloc(sizeof(int) * obj->capacity);
    if (!obj->arr) {
        free(obj);
        return NULL;
    }
    obj->size = 0;

    // Initialize hash map
    obj->map_capacity = 32; // Initial capacity for the hash map (power of 2 is good for modulo)
    obj->map_keys = (int*)malloc(sizeof(int) * obj->map_capacity);
    obj->map_values = (int*)malloc(sizeof(int) * obj->map_capacity);
    obj->map_status = (HashStatus*)malloc(sizeof(HashStatus) * obj->map_capacity);
    if (!obj->map_keys || !obj->map_values || !obj->map_status) {
        free(obj->arr);
        free(obj->map_keys);
        free(obj->map_values);
        free(obj->map_status);
        free(obj);
        return NULL;
    }
    for (int i = 0; i < obj->map_capacity; ++i) {
        obj->map_status[i] = HASH_EMPTY;
    }
    obj->map_count = 0;
    obj->map_deleted_count = 0;

    // Seed random number generator once
    static bool seeded = false;
    if (!seeded) {
        srand((unsigned int)time(NULL));
        seeded = true;
    }

    return obj;
}

static void _randomizedSet_resize_map(RandomizedSet* obj) {
    int old_capacity = obj->map_capacity;
    int* old_keys = obj->map_keys;
    int* old_values = obj->map_values;
    HashStatus* old_status = obj->map_status;

    obj->map_capacity *= 2; // Double capacity
    obj->map_keys = (int*)malloc(sizeof(int) * obj->map_capacity);
    obj->map_values = (int*)malloc(sizeof(int) * obj->map_capacity);
    obj->map_status = (HashStatus*)malloc(sizeof(HashStatus) * obj->map_capacity);

    // Basic error handling for malloc failure
    if (!obj->map_keys || !obj->map_values || !obj->map_status) {
        // In a real application, more robust error handling is needed.
        // For LeetCode, often assume success or let it crash.
        // For this problem, we'll proceed assuming success, potentially leading to issues if malloc fails.
        return; 
    }

    for (int i = 0; i < obj->map_capacity; ++i) {
        obj->map_status[i] = HASH_EMPTY;
    }
    obj->map_count = 0;
    obj->map_deleted_count = 0;

    // Re-insert all existing elements into the new, larger hash map
    for (int i = 0; i < old_capacity; ++i) {
        if (old_status[i] == HASH_OCCUPIED) {
            int val = old_keys[i];
            int arr_idx = old_values[i];

            int insert_idx;
            // This will find an EMPTY slot in the new map, as it's empty initially
            _randomizedSet_find_map_slot(obj, val, &insert_idx); 

            obj->map_keys[insert_idx] = val;
            obj->map_values[insert_idx] = arr_idx;
            obj->map_status[insert_idx] = HASH_OCCUPIED;
            obj->map_count++;
        }
    }

    free(old_keys);
    free(old_values);
    free(old_status);
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    int insert_pos = -1;
    int map_idx = _randomizedSet_find_map_slot(obj, val, &insert_pos);

    if (map_idx != -1) {
        return false; // Value already exists
    }

    // Resize hash map if load factor is too high
    // Using map_count / map_capacity > 0.5 as threshold
    if (obj->map_count * 2 >= obj->map_capacity) { 
        _randomizedSet_resize_map(obj);
        // After resize, we need to find the insert_pos again in the new map
        _randomizedSet_find_map_slot(obj, val, &insert_pos);
    }

    // Resize dynamic array if needed
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->arr = (int*)realloc(obj->arr, sizeof(int) * obj->capacity);
        if (!obj->arr) return false; // Allocation failed
    }

    // Add value to the dynamic array
    obj->arr[obj->size] = val;

    // Add value to the hash map
    obj->map_keys[insert_pos] = val;
    obj->map_values[insert_pos] = obj->size;

    if (obj->map_status[insert_pos] == HASH_DELETED) {
        obj->map_deleted_count--; // Reusing a deleted slot, so decrement deleted count
    }
    obj->map_status[insert_pos] = HASH_OCCUPIED;
    obj->map_count++;
    obj->size++;

    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    int map_idx = _randomizedSet_find_map_slot(obj, val, NULL);

    if (map_idx == -1) {
        return false; // Value not found
    }

    // Get the index of `val` in the dynamic array
    int val_arr_idx = obj->map_values[map_idx];

    // Replace `val` in `arr` with the last element
    int last_val = obj->arr[obj->size - 1];
    obj->arr[val_arr_idx] = last_val;

    // Update the hash map entry for `last_val`
    // Find `last_val` in the hash map
    int last_val_map_idx = _randomizedSet_find_map_slot(obj, last_val, NULL);
    // Update its mapped array index to the position where `val` was
    if (last_val_map_idx != -1) { // `last_val` must exist in the map
        obj->map_values[last_val_map_idx] = val_arr_idx;
    }

    // Mark the slot of `val` in the hash map as DELETED
    obj->map_status[map_idx] = HASH_DELETED;
    obj->map_count--;
    obj->map_deleted_count++;

    // Decrement the size of the dynamic array
    obj->size--;

    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    // Problem constraints usually guarantee getRandom is called on a non-empty set.
    // Added check for safety.
    if (obj->size == 0) {
        return 0; // Or handle error appropriately
    }
    int random_idx = rand() % obj->size;
    return obj->arr[random_idx];
}

void randomizedSetFree(RandomizedSet* obj) {
    if (obj) {
        free(obj->arr);
        free(obj->map_keys);
        free(obj->map_values);
        free(obj->map_status);
        free(obj);
    }
}