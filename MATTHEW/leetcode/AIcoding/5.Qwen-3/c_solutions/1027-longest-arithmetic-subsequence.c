#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int key;
    int value;
} Pair;

typedef struct {
    Pair *pairs;
    int size;
    int capacity;
} HashMap;

HashMap* createHashMap() {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = 0;
    map->capacity = 16;
    map->pairs = (Pair*)malloc(map->capacity * sizeof(Pair));
    return map;
}

void put(HashMap *map, int key, int value) {
    for (int i = 0; i < map->size; i++) {
        if (map->pairs[i].key == key) {
            map->pairs[i].value = value;
            return;
        }
    }
    if (map->size >= map->capacity) {
        map->capacity *= 2;
        map->pairs = (Pair*)realloc(map->pairs, map->capacity * sizeof(Pair));
    }
    map->pairs[map->size].key = key;
    map->pairs[map->size].value = value;
    map->size++;
}

int get(HashMap *map, int key) {
    for (int i = 0; i < map->size; i++) {
        if (map->pairs[i].key == key) {
            return map->pairs[i].value;
        }
    }
    return 0;
}

void freeHashMap(HashMap *map) {
    free(map->pairs);
    free(map);
}

int longestArithSeqLength(int* nums, int numsSize) {
    if (numsSize <= 2) return numsSize;

    int maxLen = 2;
    HashMap **dp = (HashMap**)malloc(numsSize * sizeof(HashMap*));
    for (int i = 0; i < numsSize; i++) {
        dp[i] = createHashMap();
    }

    for (int i = 0; i < numsSize; i++) {
        for (int j = 0; j < i; j++) {
            int diff = nums[i] - nums[j];
            int prevCount = get(dp[j], diff);
            int currentCount = prevCount + 1;
            put(dp[i], diff, currentCount);
            if (currentCount > maxLen) {
                maxLen = currentCount;
            }
        }
    }

    for (int i = 0; i < numsSize; i++) {
        freeHashMap(dp[i]);
    }
    free(dp);

    return maxLen;
}