#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* nums;
    int size;
    int capacity;
    int* index_map;
} RandomizedCollection;

RandomizedCollection* randomizedCollectionCreate() {
    RandomizedCollection* obj = (RandomizedCollection*)malloc(sizeof(RandomizedCollection));
    obj->nums = (int*)malloc(16 * sizeof(int));
    obj->size = 0;
    obj->capacity = 16;
    obj->index_map = (int*)calloc(100000, sizeof(int));
    return obj;
}

bool randomizedCollectionInsert(RandomizedCollection* obj, int val) {
    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
    }
    obj->nums[obj->size] = val;
    obj->index_map[val] = obj->size;
    obj->size++;
    return true;
}

bool randomizedCollectionRemove(RandomizedCollection* obj, int val) {
    if (obj->index_map[val] == -1) {
        return false;
    }
    int index = obj->index_map[val];
    int last = obj->nums[obj->size - 1];
    obj->nums[index] = last;
    obj->index_map[last] = index;
    obj->index_map[val] = -1;
    obj->size--;
    return true;
}

int randomizedCollectionGetRandom(RandomizedCollection* obj) {
    int index = rand() % obj->size;
    return obj->nums[index];
}

void randomizedCollectionFree(RandomizedCollection* obj) {
    free(obj->nums);
    free(obj->index_map);
    free(obj);
}