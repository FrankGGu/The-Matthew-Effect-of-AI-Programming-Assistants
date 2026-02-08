#include <stdlib.h> // For malloc, calloc, free

typedef struct Entry {
    long long key;
    int value;
    struct Entry* next;
} Entry;

typedef struct HashMap {
    Entry** buckets;
    int size; // number of buckets
} HashMap;

unsigned int hash(long long key, int size) {
    unsigned long long ukey = (unsigned long long)key;
    ukey = (ukey ^ (ukey >> 32));
    ukey = (ukey ^ (ukey >> 16));
    ukey = (ukey ^ (ukey >> 8));
    return (unsigned int)(ukey % size);
}

HashMap* createHashMap(int size) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->buckets = (Entry**)calloc(size, sizeof(Entry*));
    return map;
}

int get(HashMap* map, long long key) {
    unsigned int index = hash(key, map->size);
    Entry* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return 0;
}

void put(HashMap* map, long long key, int value) {
    unsigned int index = hash(key, map->size);
    Entry* current = map->buckets[index];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    Entry* newEntry = (Entry*)malloc(sizeof(Entry));
    newEntry->key = key;
    newEntry->value = value;
    newEntry->next = map->buckets[index];
    map->buckets[index] = newEntry;
}

void freeHashMap(HashMap* map) {
    if (!map) return;
    for (int i = 0; i < map->size; ++i) {
        Entry* current = map->buckets[i];
        while (current != NULL) {
            Entry* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(map->buckets);
    free(map);
}

int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) {
        return 0;
    }

    HashMap* dp[numsSize];
    int total_count = 0;

    int HASH_MAP_BUCKET_SIZE = 2003; // A prime number for hash map buckets

    for (int i = 0; i < numsSize; ++i) {
        dp[i] = createHashMap(HASH_MAP_BUCKET_SIZE);
        for (int j = 0; j < i; ++j) {
            long long diff = (long long)nums[i] - nums[j];

            int count_j_diff = get(dp[j], diff);

            total_count += count_j_diff;

            put(dp[i], diff, get(dp[i], diff) + count_j_diff + 1);
        }
    }

    for (int i = 0; i < numsSize; ++i) {
        freeHashMap(dp[i]);
    }

    return total_count;
}