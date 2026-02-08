#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int *nums;
    int *indices;
    int size;
    int capacity;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->size = 0;
    obj->capacity = 10;
    obj->nums = (int*)malloc(obj->capacity * sizeof(int));
    obj->indices = (int*)malloc(obj->capacity * sizeof(int));
    for (int i = 0; i < obj->capacity; i++) {
        obj->indices[i] = -1;
    }
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->indices[val] != -1) return false;
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
        obj->indices = (int*)realloc(obj->indices, obj->capacity * sizeof(int));
        for (int i = obj->size; i < obj->capacity; i++) {
            obj->indices[i] = -1;
        }
    }
    obj->nums[obj->size] = val;
    obj->indices[val] = obj->size;
    obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    if (obj->indices[val] == -1) return false;
    int index = obj->indices[val];
    obj->nums[index] = obj->nums[obj->size - 1];
    obj->indices[obj->nums[index]] = index;
    obj->size--;
    obj->indices[val] = -1;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    return obj->nums[rand() % obj->size];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj);
}