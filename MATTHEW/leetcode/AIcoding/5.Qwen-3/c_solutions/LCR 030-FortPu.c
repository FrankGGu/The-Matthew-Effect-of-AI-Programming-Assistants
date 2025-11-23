#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int* nums;
    int size;
    int capacity;
    int* indexMap;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->nums = (int*)malloc(10 * sizeof(int));
    obj->size = 0;
    obj->capacity = 10;
    obj->indexMap = (int*)calloc(100001, sizeof(int));
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->indexMap[val] != 0) {
        return false;
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
    }
    obj->nums[obj->size++] = val;
    obj->indexMap[val] = obj->size;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    if (obj->indexMap[val] == 0) {
        return false;
    }
    int index = obj->indexMap[val] - 1;
    int lastVal = obj->nums[obj->size - 1];
    obj->nums[index] = lastVal;
    obj->indexMap[lastVal] = index + 1;
    obj->indexMap[val] = 0;
    obj->size--;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    return obj->nums[rand() % obj->size];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->nums);
    free(obj->indexMap);
    free(obj);
}