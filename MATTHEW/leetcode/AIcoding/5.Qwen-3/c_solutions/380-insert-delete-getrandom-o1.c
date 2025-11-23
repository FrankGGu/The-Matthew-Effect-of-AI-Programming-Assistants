#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* nums;
    int* index_map;
    int size;
    int capacity;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->nums = (int*)malloc(16 * sizeof(int));
    obj->index_map = (int*)malloc(16 * sizeof(int));
    obj->size = 0;
    obj->capacity = 16;
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->size >= obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
        obj->index_map = (int*)realloc(obj->index_map, obj->capacity * sizeof(int));
    }
    for (int i = 0; i < obj->size; i++) {
        if (obj->nums[i] == val) {
            return false;
        }
    }
    obj->nums[obj->size] = val;
    obj->index_map[val] = obj->size;
    obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->nums[i] == val) {
            obj->nums[i] = obj->nums[obj->size - 1];
            obj->index_map[obj->nums[i]] = i;
            obj->size--;
            return true;
        }
    }
    return false;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    return obj->nums[rand() % obj->size];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->nums);
    free(obj->index_map);
    free(obj);
}