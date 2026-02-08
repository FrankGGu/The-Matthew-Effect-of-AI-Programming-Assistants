#include <stdlib.h>

#define HASH_TABLE_SIZE 40009

typedef struct HashNode {
    int key;
    int val;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** buckets;
    int size;
} HashMap;

unsigned int hash(int key, int table_size) {
    return (unsigned int)(((long long)key % table_size + table_size) % table_size);
}

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->buckets = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

int get(HashMap* map, int key) {
    unsigned int index = hash(key, map->size);
    HashNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->val;
        }
        current = current->next;
    }
    return 0;
}

void put(HashMap* map, int key, int val) {
    unsigned int index = hash(key, map->size);
    HashNode* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            current->val = val;
            return;
        }
        current = current->next;
    }
    HashNode* newNode = (HashNode*)malloc(sizeof(HashNode));
    newNode->key = key;
    newNode->val = val;
    newNode->next = map->buckets[index];
    map->buckets[index] = newNode;
}

void freeHashMap(HashMap* map) {
    for (int i = 0; i < map->size; i++) {
        HashNode* current = map->buckets[i];
        while (current != NULL) {
            HashNode* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

int subarraySum(int* nums, int numsSize, int k) {
    HashMap* map = createHashMap(HASH_TABLE_SIZE);

    int count = 0;
    int current_sum = 0;

    put(map, 0, 1);

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];

        count += get(map, current_sum - k);

        put(map, current_sum, get(map, current_sum) + 1);
    }

    freeHashMap(map);
    return count;
}