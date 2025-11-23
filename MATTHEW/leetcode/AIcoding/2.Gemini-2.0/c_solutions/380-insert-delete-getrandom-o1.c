#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *arr;
    int *indexMap;
    int size;
    int capacity;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->capacity = 100000;
    obj->arr = (int*)malloc(obj->capacity * sizeof(int));
    obj->indexMap = (int*)malloc(obj->capacity * sizeof(int));
    obj->size = 0;
    srand(time(NULL));
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->indexMap[val + 100000] == 0) {
        if (obj->size == obj->capacity) {
            obj->capacity *= 2;
            obj->arr = (int*)realloc(obj->arr, obj->capacity * sizeof(int));
            obj->indexMap = (int*)realloc(obj->indexMap, obj->capacity * sizeof(int));
        }
        obj->arr[obj->size] = val;
        obj->indexMap[val + 100000] = obj->size + 1;
        obj->size++;
        return true;
    }
    return false;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    if (obj->indexMap[val + 100000] != 0) {
        int index = obj->indexMap[val + 100000] - 1;
        if (index != obj->size - 1) {
            obj->arr[index] = obj->arr[obj->size - 1];
            obj->indexMap[obj->arr[index] + 100000] = index + 1;
        }
        obj->indexMap[val + 100000] = 0;
        obj->size--;
        return true;
    }
    return false;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    int randomIndex = rand() % obj->size;
    return obj->arr[randomIndex];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->arr);
    free(obj->indexMap);
    free(obj);
}