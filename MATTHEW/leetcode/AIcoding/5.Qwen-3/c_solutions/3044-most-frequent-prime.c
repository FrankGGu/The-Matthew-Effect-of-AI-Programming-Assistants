#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct {
    int key;
    int count;
} HashEntry;

typedef struct {
    HashEntry* entries;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->capacity = capacity;
    map->entries = (HashEntry*)calloc(capacity, sizeof(HashEntry));
    return map;
}

unsigned int hash(int key, int capacity) {
    return abs(key) % capacity;
}

void insertIntoHashMap(HashMap* map, int key) {
    unsigned int index = hash(key, map->capacity);
    while (map->entries[index].key != 0 || map->entries[index].count > 0) {
        index = (index + 1) % map->capacity;
    }
    map->entries[index].key = key;
    map->entries[index].count = 1;
    map->size++;
}

void incrementCount(HashMap* map, int key) {
    unsigned int index = hash(key, map->capacity);
    while (map->entries[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    map->entries[index].count++;
}

int getFrequency(HashMap* map, int key) {
    unsigned int index = hash(key, map->capacity);
    while (map->entries[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    return map->entries[index].count;
}

void freeHashMap(HashMap* map) {
    free(map->entries);
    free(map);
}

int isPrime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int getMostFrequentPrime(int** matrix, int matrixSize, int* matrixColSize) {
    int maxFreq = 0;
    int mostFrequent = -1;
    int capacity = 10000;
    HashMap* primeMap = createHashMap(capacity);

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[i]; j++) {
            int num = matrix[i][j];
            if (isPrime(num)) {
                if (getFrequency(primeMap, num) == 0) {
                    insertIntoHashMap(primeMap, num);
                } else {
                    incrementCount(primeMap, num);
                }
            }
        }
    }

    for (int i = 0; i < capacity; i++) {
        if (primeMap->entries[i].key != 0 && primeMap->entries[i].count > maxFreq) {
            maxFreq = primeMap->entries[i].count;
            mostFrequent = primeMap->entries[i].key;
        }
    }

    freeHashMap(primeMap);
    return mostFrequent;
}