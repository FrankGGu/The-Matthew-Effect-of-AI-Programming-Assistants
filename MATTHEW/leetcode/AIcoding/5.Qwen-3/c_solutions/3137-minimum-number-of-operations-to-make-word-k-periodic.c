#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *key;
    int count;
} HashEntry;

typedef struct {
    HashEntry *entries;
    int size;
    int capacity;
} HashMap;

unsigned long hash(const char *str) {
    unsigned long hash = 5381;
    int c;
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

HashMap *createHashMap(int capacity) {
    HashMap *map = (HashMap *)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->entries = (HashEntry *)calloc(capacity, sizeof(HashEntry));
    return map;
}

void freeHashMap(HashMap *map) {
    for (int i = 0; i < map->capacity; i++) {
        free(map->entries[i].key);
    }
    free(map->entries);
    free(map);
}

void insertIntoHashMap(HashMap *map, const char *key) {
    unsigned long h = hash(key);
    int index = h % map->capacity;
    while (map->entries[index].key != NULL) {
        if (strcmp(map->entries[index].key, key) == 0) {
            map->entries[index].count++;
            return;
        }
        index = (index + 1) % map->capacity;
    }
    map->entries[index].key = strdup(key);
    map->entries[index].count = 1;
    map->size++;
}

int getFrequency(HashMap *map, const char *key) {
    unsigned long h = hash(key);
    int index = h % map->capacity;
    while (map->entries[index].key != NULL) {
        if (strcmp(map->entries[index].key, key) == 0) {
            return map->entries[index].count;
        }
        index = (index + 1) % map->capacity;
    }
    return 0;
}

int minOperationsToMakeKPeriodic(char *word, int k) {
    int n = strlen(word);
    int total = 0;
    int maxFreq = 0;
    HashMap *map = createHashMap(n / k + 1);
    for (int i = 0; i < n; i += k) {
        int len = (i + k <= n) ? k : n - i;
        char *sub = (char *)malloc(len + 1);
        strncpy(sub, word + i, len);
        sub[len] = '\0';
        insertIntoHashMap(map, sub);
        free(sub);
    }
    for (int i = 0; i < map->capacity; i++) {
        if (map->entries[i].key != NULL) {
            int freq = map->entries[i].count;
            if (freq > maxFreq) {
                maxFreq = freq;
            }
        }
    }
    freeHashMap(map);
    return n - maxFreq * k;
}