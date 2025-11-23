#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int value;
} Pair;

typedef struct {
    Pair *data;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->data = (Pair*)calloc(capacity, sizeof(Pair));
    map->size = 0;
    map->capacity = capacity;
    return map;
}

void freeHashMap(HashMap *map) {
    free(map->data);
    free(map);
}

int getHash(int key, int capacity) {
    return abs(key) % capacity;
}

void put(HashMap *map, int key, int value) {
    int index = getHash(key, map->capacity);
    while (map->data[index].key != 0 && map->data[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    if (map->data[index].key == 0) {
        map->size++;
    }
    map->data[index].key = key;
    map->data[index].value = value;
}

int get(HashMap *map, int key) {
    int index = getHash(key, map->capacity);
    while (map->data[index].key != 0) {
        if (map->data[index].key == key) {
            return map->data[index].value;
        }
        index = (index + 1) % map->capacity;
    }
    return 0;
}

int sumOfSquares(int *nums, int numsSize) {
    HashMap *countMap = createHashMap(numsSize * 2);
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        int num = nums[i];
        int freq = get(countMap, num);
        if (freq > 0) {
            result -= freq * freq;
        }
        freq++;
        result += freq * freq;
        put(countMap, num, freq);
    }
    freeHashMap(countMap);
    return result;
}