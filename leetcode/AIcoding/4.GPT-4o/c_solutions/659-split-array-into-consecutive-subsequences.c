#include <stdlib.h>
#include <stdbool.h>

struct HashMap {
    int *keys;
    int *values;
    int size;
    int capacity;
};

struct HashMap* createHashMap(int capacity) {
    struct HashMap *map = malloc(sizeof(struct HashMap));
    map->keys = calloc(capacity, sizeof(int));
    map->values = calloc(capacity, sizeof(int));
    map->size = 0;
    map->capacity = capacity;
    return map;
}

void freeHashMap(struct HashMap *map) {
    free(map->keys);
    free(map->values);
    free(map);
}

int hash(int key, int capacity) {
    return (key % capacity + capacity) % capacity;
}

void put(struct HashMap *map, int key, int value) {
    int idx = hash(key, map->capacity);
    while (map->values[idx] != 0) {
        if (map->keys[idx] == key) {
            map->values[idx] = value;
            return;
        }
        idx = (idx + 1) % map->capacity;
    }
    map->keys[idx] = key;
    map->values[idx] = value;
    map->size++;
}

int get(struct HashMap *map, int key) {
    int idx = hash(key, map->capacity);
    while (map->values[idx] != 0) {
        if (map->keys[idx] == key) {
            return map->values[idx];
        }
        idx = (idx + 1) % map->capacity;
    }
    return 0;
}

bool containsKey(struct HashMap *map, int key) {
    int idx = hash(key, map->capacity);
    while (map->values[idx] != 0) {
        if (map->keys[idx] == key) {
            return true;
        }
        idx = (idx + 1) % map->capacity;
    }
    return false;
}

bool isPossible(int* nums, int numsSize) {
    if (numsSize < 3) return false;
    struct HashMap *freq = createHashMap(numsSize);
    struct HashMap *tail = createHashMap(numsSize);

    for (int i = 0; i < numsSize; i++) {
        put(freq, nums[i], get(freq, nums[i]) + 1);
    }

    for (int i = 0; i < numsSize; i++) {
        if (get(freq, nums[i]) == 0) continue;
        if (get(tail, nums[i] - 1) > 0) {
            put(tail, nums[i] - 1, get(tail, nums[i] - 1) - 1);
            put(tail, nums[i], get(tail, nums[i]) + 1);
        } else if (get(freq, nums[i] + 1) > 0 && get(freq, nums[i] + 2) > 0) {
            put(freq, nums[i] + 1, get(freq, nums[i] + 1) - 1);
            put(freq, nums[i] + 2, get(freq, nums[i] + 2) - 1);
            put(tail, nums[i] + 2, get(tail, nums[i + 2]) + 1);
        } else {
            freeHashMap(freq);
            freeHashMap(tail);
            return false;
        }
        put(freq, nums[i], get(freq, nums[i]) - 1);
    }

    freeHashMap(freq);
    freeHashMap(tail);
    return true;
}