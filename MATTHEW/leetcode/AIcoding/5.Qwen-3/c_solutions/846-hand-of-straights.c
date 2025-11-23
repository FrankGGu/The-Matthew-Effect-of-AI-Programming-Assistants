#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int key;
    int value;
} Pair;

typedef struct {
    Pair* data;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap() {
    HashMap* map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->capacity = 16;
    map->data = (Pair*)calloc(map->capacity, sizeof(Pair));
    return map;
}

void freeHashMap(HashMap* map) {
    free(map->data);
    free(map);
}

int hash(int key, int capacity) {
    return abs(key) % capacity;
}

void put(HashMap* map, int key, int value) {
    int index = hash(key, map->capacity);
    while (map->data[index].key != 0 && map->data[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    if (map->data[index].key == 0) {
        map->size++;
    }
    map->data[index].key = key;
    map->data[index].value = value;
}

int get(HashMap* map, int key) {
    int index = hash(key, map->capacity);
    while (map->data[index].key != 0) {
        if (map->data[index].key == key) {
            return map->data[index].value;
        }
        index = (index + 1) % map->capacity;
    }
    return -1;
}

bool isNStraightHand(int* hand, int handSize, int groupSize) {
    if (groupSize == 1) {
        return true;
    }

    HashMap* count = createHashMap();
    for (int i = 0; i < handSize; i++) {
        int c = get(count, hand[i]);
        put(count, hand[i], c + 1);
    }

    int* sorted = (int*)malloc(handSize * sizeof(int));
    for (int i = 0; i < handSize; i++) {
        sorted[i] = hand[i];
    }

    qsort(sorted, handSize, sizeof(int), (int(*)(const void*, const void*))strcmp);

    for (int i = 0; i < handSize; i++) {
        int current = sorted[i];
        int c = get(count, current);
        if (c == 0) {
            continue;
        }
        for (int j = 0; j < groupSize; j++) {
            int next = current + j;
            int cnt = get(count, next);
            if (cnt == 0) {
                freeHashMap(count);
                free(sorted);
                return false;
            }
            put(count, next, cnt - 1);
        }
    }

    freeHashMap(count);
    free(sorted);
    return true;
}