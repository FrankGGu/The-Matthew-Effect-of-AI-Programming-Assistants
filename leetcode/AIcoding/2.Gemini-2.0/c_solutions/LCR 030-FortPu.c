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
    obj->size = 0;
    obj->arr = (int*)malloc(obj->capacity * sizeof(int));
    obj->indexMap = (int*)malloc(obj->capacity * sizeof(int));
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->arr[i] == val) {
            return false;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->arr = (int*)realloc(obj->arr, obj->capacity * sizeof(int));
        obj->indexMap = (int*)realloc(obj->indexMap, obj->capacity * sizeof(int));
    }
    obj->arr[obj->size] = val;
    obj->indexMap[val] = obj->size;
    obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    int index = -1;
    for (int i = 0; i < obj->size; i++) {
        if (obj->arr[i] == val) {
            index = i;
            break;
        }
    }
    if (index == -1) {
        return false;
    }

    obj->arr[index] = obj->arr[obj->size - 1];
    obj->indexMap[obj->arr[index]] = index;
    obj->size--;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    if (obj->size == 0) return -1;
    return obj->arr[rand() % obj->size];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->arr);
    free(obj->indexMap);
    free(obj);
}