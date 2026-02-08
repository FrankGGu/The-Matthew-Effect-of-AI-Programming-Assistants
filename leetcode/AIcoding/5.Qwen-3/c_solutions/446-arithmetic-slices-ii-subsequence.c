#include <stdio.h>
#include <stdlib.h>

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
    map->data = (Pair*)malloc(capacity * sizeof(Pair));
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
    map->data[index].value += value;
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

int numberOfArithmeticSlices(int* nums, int numsSize) {
    if (numsSize < 3) return 0;
    int result = 0;
    HashMap **dp = (HashMap**)malloc(numsSize * sizeof(HashMap*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = createHashMap(1000);
    }
    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            long long diff = (long long)nums[i] - nums[j];
            int count = get(dp[j], diff);
            result += count;
            put(dp[i], diff, count + 1);
        }
    }
    for (int i = 0; i < numsSize; i++) {
        freeHashMap(dp[i]);
    }
    free(dp);
    return result;
}