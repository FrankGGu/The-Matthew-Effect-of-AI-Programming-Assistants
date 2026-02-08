#include <stdlib.h>
#include <stdbool.h>

typedef struct HashNode {
    long long key;
    int reset_id;
    struct HashNode *next;
} HashNode;

typedef struct {
    HashNode **table;
    int size;
    int count;
} HashMap;

unsigned int hash(long long key, int size) {
    return (unsigned int)(((key * 31 % size) + size) % size);
}

HashMap* createHashMap(int size) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->count = 0;
    map->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

void hashMapAdd(HashMap *map, long long key, int reset_id) {
    unsigned int index = hash(key, map->size);
    HashNode *current = map->table[index];
    while (current != NULL) {
        if (current->key == key) {
            current->reset_id = reset_id;
            return;
        }
        current = current->next;
    }
    HashNode *newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->reset_id = reset_id;
    newNode->next = map->table[index];
    map->table[index] = newNode;
    map->count++;
}

bool hashMapContains(HashMap *map, long long key, int current_reset_id) {
    unsigned int index = hash(key, map->size);
    HashNode *current = map->table[index];
    while (current != NULL) {
        if (current->key == key && current->reset_id == current_reset_id) {
            return true;
        }
        current = current->next;
    }
    return false;
}

void freeHashMap(HashMap *map) {
    for (int i = 0; i < map->size; i++) {
        HashNode *current = map->table[i];
        while (current != NULL) {
            HashNode *temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->table);
    free(map);
}

int maxNonOverlapping(int* nums, int numsSize, int target) {
    int count = 0;
    long long prefix_sum = 0;
    int current_reset_id = 0;

    HashMap *seen_sums_map = createHashMap(200003); 

    hashMapAdd(seen_sums_map, 0, current_reset_id);

    for (int i = 0; i < numsSize; i++) {
        prefix_sum += nums[i];

        if (hashMapContains(seen_sums_map, prefix_sum - target, current_reset_id)) {
            count++;
            current_reset_id++;
            hashMapAdd(seen_sums_map, prefix_sum, current_reset_id);
        } else {
            hashMapAdd(seen_sums_map, prefix_sum, current_reset_id);
        }
    }

    freeHashMap(seen_sums_map);

    return count;
}