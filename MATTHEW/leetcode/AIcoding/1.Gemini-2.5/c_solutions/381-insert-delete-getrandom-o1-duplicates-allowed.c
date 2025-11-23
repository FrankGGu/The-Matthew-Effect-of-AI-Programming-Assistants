#include <stdbool.h>
#include <stdlib.h>
#include <time.h> // For srand

typedef struct {
    int* data;
    int size;
    int capacity;
} IntVector;

void IntVector_init(IntVector* vec) {
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

void IntVector_resize(IntVector* vec, int new_capacity) {
    if (new_capacity < vec->size) {
        new_capacity = vec->size;
    }
    if (new_capacity == 0) {
        free(vec->data);
        vec->data = NULL;
        vec->capacity = 0;
        return;
    }
    int* new_data = (int*)realloc(vec->data, new_capacity * sizeof(int));
    if (new_data == NULL) {
        exit(EXIT_FAILURE); // Handle realloc failure
    }
    vec->data = new_data;
    vec->capacity = new_capacity;
}

void IntVector_add(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        IntVector_resize(vec, vec->capacity == 0 ? 16 : vec->capacity * 2);
    }
    vec->data[vec->size++] = val;
}

void IntVector_set(IntVector* vec, int index, int val) {
    vec->data[index] = val;
}

void IntVector_free(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->size = 0;
    vec->capacity = 0;
}

#define INITIAL_HASH_BUCKETS 16
#define LOAD_FACTOR_NUMERATOR 3
#define LOAD_FACTOR_DENOMINATOR 4 // 0.75

typedef struct IntHashSetNode {
    int key; // An index
    struct IntHashSetNode* next;
} IntHashSetNode;

typedef struct {
    IntHashSetNode** buckets;
    int num_buckets;
    int size; // Number of elements in the set
} IntHashSet;

unsigned int IntHashSet_hash(int key, int num_buckets) {
    return (unsigned int)abs(key) % num_buckets;
}

void IntHashSet_init(IntHashSet* set) {
    set->num_buckets = INITIAL_HASH_BUCKETS;
    set->buckets = (IntHashSetNode**)calloc(set->num_buckets, sizeof(IntHashSetNode*));
    set->size = 0;
}

void IntHashSet_resize(IntHashSet* set, int new_num_buckets) {
    IntHashSetNode** old_buckets = set->buckets;
    int old_num_buckets = set->num_buckets;

    set->num_buckets = new_num_buckets;
    set->buckets = (IntHashSetNode**)calloc(new_num_buckets, sizeof(IntHashSetNode*));
    set->size = 0; // Will be re-calculated during re-insertion

    for (int i = 0; i < old_num_buckets; i++) {
        IntHashSetNode* current = old_buckets[i];
        while (current != NULL) {
            IntHashSetNode* next = current->next;
            unsigned int bucket_idx = IntHashSet_hash(current->key, set->num_buckets);
            current->next = set->buckets[bucket_idx];
            set->buckets[bucket_idx] = current;
            set->size++;
            current = next;
        }
    }
    free(old_buckets);
}

void IntHashSet_add(IntHashSet* set, int key) {
    if ((set->size * LOAD_FACTOR_DENOMINATOR) >= (set->num_buckets * LOAD_FACTOR_NUMERATOR)) {
        IntHashSet_resize(set, set->num_buckets * 2);
    }

    unsigned int bucket_idx = IntHashSet_hash(key, set->num_buckets);
    IntHashSetNode* current = set->buckets[bucket_idx];
    while (current != NULL) {
        if (current->key == key) {
            return; // Key already exists
        }
        current = current->next;
    }

    IntHashSetNode* new_node = (IntHashSetNode*)malloc(sizeof(IntHashSetNode));
    new_node->key = key;
    new_node->next = set->buckets[bucket_idx];
    set->buckets[bucket_idx] = new_node;
    set->size++;
}

void IntHashSet_remove(IntHashSet* set, int key) {
    unsigned int bucket_idx = IntHashSet_hash(key, set->num_buckets);
    IntHashSetNode* current = set->buckets[bucket_idx];
    IntHashSetNode* prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) {
                set->buckets[bucket_idx] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            set->size--;
            return;
        }
        prev = current;
        current = current->next;
    }
}

bool IntHashSet_contains(IntHashSet* set, int key) {
    unsigned int bucket_idx = IntHashSet_hash(key, set->num_buckets);
    IntHashSetNode* current = set->buckets[bucket_idx];
    while (current != NULL) {
        if (current->key == key) {
            return true;
        }
        current = current->next;
    }
    return false;
}

int IntHashSet_get_any(IntHashSet* set) {
    if (set->size == 0) return -1; 
    for (int i = 0; i < set->num_buckets; i++) {
        if (set->buckets[i] != NULL) {
            return set->buckets[i]->key;
        }
    }
    return -1; // Should not be reached if size > 0
}

void IntHashSet_free(IntHashSet* set) {
    for (int i = 0; i < set->num_buckets; i++) {
        IntHashSetNode* current = set->buckets[i];
        while (current != NULL) {
            IntHashSetNode* next = current->next;
            free(current);
            current = next;
        }
    }
    free(set->buckets);
    set->buckets = NULL;
    set->size = 0;
    set->num_buckets = 0;
}

typedef struct ValToIndicesMapNode {
    int key; // A value from the problem
    IntHashSet* indices_set; // Pointer to a hash set of indices
    struct ValToIndicesMapNode* next;
} ValToIndicesMapNode;

typedef struct {
    ValToIndicesMapNode** buckets;
    int num_buckets;
    int size; // Number of unique keys
} ValToIndicesMap;

unsigned int ValToIndicesMap_hash(int key, int num_buckets) {
    return (unsigned int)abs(key) % num_buckets;
}

void ValToIndicesMap_init(ValToIndicesMap* map) {
    map->num_buckets = INITIAL_HASH_BUCKETS;
    map->buckets = (ValToIndicesMapNode**)calloc(map->num_buckets, sizeof(ValToIndicesMapNode*));
    map->size = 0;
}

void ValToIndicesMap_resize(ValToIndicesMap* map, int new_num_buckets) {
    ValToIndicesMapNode** old_buckets = map->buckets;
    int old_num_buckets = map->num_buckets;

    map->num_buckets = new_num_buckets;
    map->buckets = (ValToIndicesMapNode**)calloc(new_num_buckets, sizeof(ValToIndicesMapNode*));
    map->size = 0; // Will be re-calculated during re-insertion

    for (int i = 0; i < old_num_buckets; i++) {
        ValToIndicesMapNode* current = old_buckets[i];
        while (current != NULL) {
            ValToIndicesMapNode* next = current->next;
            unsigned int bucket_idx = ValToIndicesMap_hash(current->key, map->num_buckets);
            current->next = map->buckets[bucket_idx];
            map->buckets[bucket_idx] = current;
            map->size++;
            current = next;
        }
    }
    free(old_buckets);
}

IntHashSet* ValToIndicesMap_get(ValToIndicesMap* map, int key) {
    unsigned int bucket_idx = ValToIndicesMap_hash(key, map->num_buckets);
    ValToIndicesMapNode* current = map->buckets[bucket_idx];
    while (current != NULL) {
        if (current->key == key) {
            return current->indices_set;
        }
        current = current->next;
    }
    return NULL;
}

void ValToIndicesMap_put(ValToIndicesMap* map, int key, IntHashSet* set) {
    if ((map->size * LOAD_FACTOR_DENOMINATOR) >= (map->num_buckets * LOAD_FACTOR_NUMERATOR)) {
        ValToIndicesMap_resize(map, map->num_buckets * 2);
    }

    unsigned int bucket_idx = ValToIndicesMap_hash(key, map->num_buckets);
    ValToIndicesMapNode* current = map->buckets[bucket_idx];
    while (current != NULL) {
        if (current->key == key) {
            return; 
        }
        current = current->next;
    }

    ValToIndicesMapNode* new_node = (ValToIndicesMapNode*)malloc(sizeof(ValToIndicesMapNode));
    new_node->key = key;
    new_node->indices_set = set;
    new_node->next = map->buckets[bucket_idx];
    map->buckets[bucket_idx] = new_node;
    map->size++;
}

void ValToIndicesMap_remove(ValToIndicesMap* map, int key) {
    unsigned int bucket_idx = ValToIndicesMap_hash(key, map->num_buckets);
    ValToIndicesMapNode* current = map->buckets[bucket_idx];
    ValToIndicesMapNode* prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) {
                map->buckets[bucket_idx] = current->next;
            } else {
                prev->next = current->next;
            }
            IntHashSet_free(current->indices_set); // Free the associated hash set contents
            free(current->indices_set); // Free the IntHashSet struct itself
            free(current);
            map->size--;
            return;
        }
        prev = current;
        current = current->next;
    }
}

void ValToIndicesMap_free(ValToIndicesMap* map) {
    for (int i = 0; i < map->num_buckets; i++) {
        ValToIndicesMapNode* current = map->buckets[i];
        while (current != NULL) {
            ValToIndicesMapNode* next = current->next;
            IntHashSet_free(current->indices_set);
            free(current->indices_set);
            free(current);
            current = next;
        }
    }
    free(map->buckets);
    map->buckets = NULL;
    map->size = 0;
    map->num_buckets = 0;
}

typedef struct {
    IntVector* arr; // Stores the actual elements
    ValToIndicesMap* val_to_indices; // Maps value to a hash set of its indices in arr
} RandomizedCollection;

RandomizedCollection* randomizedCollectionCreate() {
    srand(time(NULL)); 

    RandomizedCollection* obj = (RandomizedCollection*)malloc(sizeof(RandomizedCollection));
    obj->arr = (IntVector*)malloc(sizeof(IntVector));
    IntVector_init(obj->arr);
    obj->val_to_indices = (ValToIndicesMap*)malloc(sizeof(ValToIndicesMap));
    ValToIndicesMap_init(obj->val_to_indices);
    return obj;
}

bool randomizedCollectionInsert(RandomizedCollection* obj, int val) {
    bool was_present = ValToIndicesMap_contains(obj->val_to_indices, val);

    IntVector_add(obj->arr, val);
    int current_idx = obj->arr->size - 1;

    IntHashSet* indices_set = ValToIndicesMap_get(obj->val_to_indices, val);
    if (indices_set == NULL) {
        indices_set = (IntHashSet*)malloc(sizeof(IntHashSet));
        IntHashSet_init(indices_set);
        ValToIndicesMap_put(obj->val_to_indices, val, indices_set);
    }
    IntHashSet_add(indices_set, current_idx);

    return !was_present;
}

bool randomizedCollectionRemove(RandomizedCollection* obj, int val) {
    IntHashSet* indices_set_for_val = ValToIndicesMap_get(obj->val_to_indices, val);
    if (indices_set_for_val == NULL || indices_set_for_val->size == 0) {
        return false; 
    }

    int idx_to_remove = IntHashSet_get_any(indices_set_for_val);

    IntHashSet_remove(indices_set_for_val, idx_to_remove);
    if (indices_set_for_val->size == 0) {
        ValToIndicesMap_remove(obj->val_to_indices, val); 
    }

    int last_idx = obj->arr->size - 1;
    int last_val = obj->arr->data[last_idx];

    if (idx_to_remove != last_idx) {
        IntVector_set(obj->arr, idx_to_remove, last_val);

        IntHashSet* indices_set_for_last_val = ValToIndicesMap_get(obj->val_to_indices, last_val);
        IntHashSet_remove(indices_set_for_last_val, last_idx);
        IntHashSet_add(indices_set_for_last_val, idx_to_remove);
    }
    obj->arr->size--;

    return true;
}

int randomizedCollectionGetRandom(RandomizedCollection* obj) {
    if (obj->arr->size == 0) {
        return -1; // Or handle error as per problem spec
    }
    int random_idx = rand() % obj->arr->size;
    return obj->arr->data[random_idx];
}

void randomizedCollectionFree(RandomizedCollection* obj) {
    IntVector_free(obj->arr);
    free(obj->arr);
    ValToIndicesMap_free(obj->val_to_indices);
    free(obj->val_to_indices);
    free(obj);
}