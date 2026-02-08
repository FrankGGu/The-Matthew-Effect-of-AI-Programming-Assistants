#include <stdio.h>
#include <stdlib.h>

struct HashMap {
    int* keys;
    int* values;
    int size;
    int capacity;
};

struct HashMap* createHashMap(int capacity) {
    struct HashMap* map = (struct HashMap*)malloc(sizeof(struct HashMap));
    map->keys = (int*)malloc(sizeof(int) * capacity);
    map->values = (int*)malloc(sizeof(int) * capacity);
    map->size = 0;
    map->capacity = capacity;
    return map;
}

int hash(int key, int capacity) {
    return abs(key) % capacity;
}

void insert(struct HashMap* map, int key, int value) {
    int index = hash(key, map->capacity);
    while (map->keys[index] != 0) {
        if (map->keys[index] == key) {
            map->values[index] += value;
            return;
        }
        index = (index + 1) % map->capacity;
    }
    map->keys[index] = key;
    map->values[index] = value;
    map->size++;
}

int countUniqueOccurrences(int* arr, int arrSize) {
    struct HashMap* map = createHashMap(arrSize);
    for (int i = 0; i < arrSize; i++) {
        insert(map, arr[i], 1);
    }

    int* occurrence = (int*)malloc(sizeof(int) * map->size);
    int occurrenceSize = 0;
    for (int i = 0; i < map->capacity; i++) {
        if (map->keys[i] != 0) {
            occurrence[occurrenceSize++] = map->values[i];
        }
    }

    qsort(occurrence, occurrenceSize, sizeof(int), (int(*)(const void*, const void*))compare);
    int uniqueCount = 1;
    for (int i = 1; i < occurrenceSize; i++) {
        if (occurrence[i] != occurrence[i - 1]) {
            uniqueCount++;
        }
    }

    free(map->keys);
    free(map->values);
    free(map);
    free(occurrence);
    return uniqueCount;
}

int compare(const int* a, const int* b) {
    return *a - *b;
}