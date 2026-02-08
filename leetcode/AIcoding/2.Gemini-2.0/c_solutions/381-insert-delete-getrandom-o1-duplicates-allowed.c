#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *nums;
    int *indices;
    int numsSize;
    int indicesSize;
    int capacity;
} RandomizedCollection;

RandomizedCollection* randomizedCollectionCreate() {
    RandomizedCollection* obj = (RandomizedCollection*)malloc(sizeof(RandomizedCollection));
    obj->nums = (int*)malloc(sizeof(int) * 100000);
    obj->indices = (int*)malloc(sizeof(int) * 100000);
    obj->numsSize = 0;
    obj->indicesSize = 0;
    obj->capacity = 100000;
    srand(time(NULL));
    return obj;
}

bool randomizedCollectionInsert(RandomizedCollection* obj, int val) {
    if (obj->numsSize == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, sizeof(int) * obj->capacity);
        obj->indices = (int*)realloc(obj->indices, sizeof(int) * obj->capacity);
    }

    obj->nums[obj->numsSize] = val;
    obj->numsSize++;

    bool existed = false;
    for(int i = 0; i < obj->indicesSize; i++){
        if(obj->indices[i] == val){
            existed = true;
            break;
        }
    }

    bool firstTime = true;
    for (int i = 0; i < obj->indicesSize; i++) {
        if (obj->indices[i] == val) {
            firstTime = false;
            break;
        }
    }

    if(firstTime){
        obj->indices[obj->indicesSize] = val;
        obj->indicesSize++;
    }

    return !existed;
}

bool randomizedCollectionRemove(RandomizedCollection* obj, int val) {
    for (int i = 0; i < obj->numsSize; i++) {
        if (obj->nums[i] == val) {
            obj->nums[i] = obj->nums[obj->numsSize - 1];
            obj->numsSize--;
            return true;
        }
    }
    return false;
}

int randomizedCollectionGetRandom(RandomizedCollection* obj) {
    if (obj->numsSize == 0) {
        return -1;
    }
    int randomIndex = rand() % obj->numsSize;
    return obj->nums[randomIndex];
}

void randomizedCollectionFree(RandomizedCollection* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj);
}