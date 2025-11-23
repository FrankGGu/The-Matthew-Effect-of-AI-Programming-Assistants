#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* nums;
    int* indices;
    int size;
    int capacity;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet* obj = (RandomizedSet*)malloc(sizeof(RandomizedSet));
    obj->capacity = 1000;
    obj->size = 0;
    obj->nums = (int*)malloc(obj->capacity * sizeof(int));
    obj->indices = (int*)malloc(1000001 * sizeof(int));
    for (int i = 0; i <= 1000000; i++) {
        obj->indices[i] = -1;
    }
    return obj;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->indices[val] != -1) {
        return false;
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
    }
    obj->nums[obj->size] = val;
    obj->indices[val] = obj->size;
    obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    if (obj->indices[val] == -1) {
        return false;
    }
    int last = obj->nums[obj->size - 1];
    int idx = obj->indices[val];
    obj->nums[idx] = last;
    obj->indices[last] = idx;
    obj->indices[val] = -1;
    obj->size--;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    int randomIndex = rand() % obj->size;
    return obj->nums[randomIndex];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj);
}

/**
 * Your RandomizedSet struct will be instantiated and called as such:
 * RandomizedSet* obj = randomizedSetCreate();
 * bool param_1 = randomizedSetInsert(obj, val);

 * bool param_2 = randomizedSetRemove(obj, val);

 * int param_3 = randomizedSetGetRandom(obj);

 * randomizedSetFree(obj);
*/