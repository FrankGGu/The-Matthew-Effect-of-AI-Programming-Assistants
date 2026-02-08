#include <stdlib.h> // For malloc, free, rand, srand
#include <time.h>   // For time (to seed srand)

typedef struct MapNode {
    int key;
    int val;
    struct MapNode* next;
} MapNode;

typedef struct {
    MapNode** buckets;
    int capacity; // Size of the buckets array
} HashMap;

static int hash(int key, int capacity) {
    // A common prime for hashing integers to improve distribution
    unsigned int h = key;
    h = h * 2654435761U; 
    return h % capacity;
}

static HashMap* hashMapCreate(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->buckets = (MapNode**)calloc(capacity, sizeof(MapNode*)); // calloc initializes to NULL
    return map;
}

static void hashMapPut(HashMap* map, int key, int val) {
    int idx = hash(key, map->capacity);
    MapNode* current = map->buckets[idx];
    while (current != NULL) {
        if (current->key == key) {
            current->val = val; // Key already exists, update value
            return;
        }
        current = current->next;
    }
    // Key not found, add new node at the head of the list
    MapNode* newNode = (MapNode*)malloc(sizeof(MapNode));
    newNode->key = key;
    newNode->val = val;
    newNode->next = map->buckets[idx];
    map->buckets[idx] = newNode;
}

static int* hashMapGet(HashMap* map, int key) {
    int idx = hash(key, map->capacity);
    MapNode* current = map->buckets[idx];
    while (current != NULL) {
        if (current->key == key) {
            return &(current->val); // Return pointer to value
        }
        current = current->next;
    }
    return NULL; // Key not found
}

static void hashMapFree(HashMap* map) {
    if (map == NULL) return;
    for (int i = 0; i < map->capacity; ++i) {
        MapNode* current = map->buckets[i];
        while (current != NULL) {
            MapNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

typedef struct {
    int n;
    int M; // Effective range size: n - blacklistSize
    HashMap* mappings;      // Stores mappings for blacklisted numbers in [0, M-1]
    HashMap* blacklist_set; // Temporary set to quickly check if a number is blacklisted during setup
} Solution;

static int isBlacklisted(HashMap* blacklist_set, int num) {
    return hashMapGet(blacklist_set, num) != NULL;
}

Solution* solutionCreate(int n, int* blacklist, int blacklistSize) {
    // Seed random number generator only once.
    static int seeded = 0;
    if (!seeded) {
        srand(time(NULL));
        seeded = 1;
    }

    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->n = n;
    obj->M = n - blacklistSize;

    // Estimate hash map capacity. Using 2x blacklistSize to keep load factor low.
    // Add 1 to ensure capacity is at least 1 even if blacklistSize is 0.
    int map_capacity = blacklistSize * 2 + 1;
    if (map_capacity < 16) map_capacity = 16; // Ensure a minimum reasonable capacity

    obj->mappings = hashMapCreate(map_capacity);
    obj->blacklist_set = hashMapCreate(map_capacity);

    // 1. Populate blacklist_set: Store all blacklisted numbers for quick lookup.
    for (int i = 0; i < blacklistSize; ++i) {
        hashMapPut(obj->blacklist_set, blacklist[i], 1); // Value 1 indicates presence
    }

    // 2. Populate mappings:
    // `last_available_num` starts from n-1 and moves downwards.
    // It finds unblacklisted numbers in the range [M, n-1] to map to.
    int last_available_num = n - 1;

    // Iterate through the original blacklist array
    for (int i = 0; i < blacklistSize; ++i) {
        int b_num = blacklist[i];

        // If 'b_num' is in the 'main' pickable range [0, M-1] AND it's blacklisted,
        // we need to map it to an unblacklisted number from the 'tail' range [M, n-1].
        if (b_num < obj->M) {
            // Find the largest available unblacklisted number starting from `last_available_num`.
            while (isBlacklisted(obj->blacklist_set, last_available_num)) {
                last_available_num--;
            }

            // Map the blacklisted number `b_num` to the found `last_available_num`.
            hashMapPut(obj->mappings, b_num, last_available_num);

            // Decrement `last_available_num` for the next mapping to ensure unique assignments.
            last_available_num--;
        }
    }

    return obj;
}

int solutionPick(Solution* obj) {
    // Pick a random number `r` from the effective range [0, M-1]
    // Note: If obj->M is very large and RAND_MAX is small, this might not be perfectly uniform.
    // For typical LeetCode environments, this is usually accepted.
    int r = rand() % obj->M;

    // Check if `r` is one of the blacklisted numbers that needs remapping.
    int* mapped_val = hashMapGet(obj->mappings, r);
    if (mapped_val != NULL) {
        return *mapped_val; // Return the remapped unblacklisted number
    } else {
        return r; // `r` is not blacklisted in the effective range, return it directly
    }
}

void solutionFree(Solution* obj) {
    if (obj == NULL) return;
    hashMapFree(obj->mappings);
    hashMapFree(obj->blacklist_set); // Free the temporary blacklist set
    free(obj);
}