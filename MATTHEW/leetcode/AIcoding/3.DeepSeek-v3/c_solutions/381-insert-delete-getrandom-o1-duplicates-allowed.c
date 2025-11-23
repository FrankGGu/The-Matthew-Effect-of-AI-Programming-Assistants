#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int* nums;
    int* indices;
    int* count;
    int size;
    int capacity;
} RandomizedCollection;

RandomizedCollection* randomizedCollectionCreate() {
    RandomizedCollection* obj = (RandomizedCollection*)malloc(sizeof(RandomizedCollection));
    obj->capacity = 1000;
    obj->nums = (int*)malloc(obj->capacity * sizeof(int));
    obj->indices = (int*)malloc(obj->capacity * sizeof(int));
    obj->count = (int*)calloc(obj->capacity, sizeof(int));
    obj->size = 0;
    return obj;
}

bool randomizedCollectionInsert(RandomizedCollection* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->nums = (int*)realloc(obj->nums, obj->capacity * sizeof(int));
        obj->indices = (int*)realloc(obj->indices, obj->capacity * sizeof(int));
        obj->count = (int*)realloc(obj->count, obj->capacity * sizeof(int));
    }

    bool not_exists = true;
    for (int i = 0; i < obj->size; i++) {
        if (obj->nums[i] == val) {
            not_exists = false;
            break;
        }
    }

    obj->nums[obj->size] = val;
    obj->indices[obj->size] = obj->size;
    obj->count[obj->size] = 1;
    obj->size++;

    return not_exists;
}

bool randomizedCollectionRemove(RandomizedCollection* obj, int val) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->nums[i] == val) {
            for (int j = i; j < obj->size - 1; j++) {
                obj->nums[j] = obj->nums[j + 1];
                obj->indices[j] = obj->indices[j + 1];
                obj->count[j] = obj->count[j + 1];
            }
            obj->size--;
            return true;
        }
    }
    return false;
}

int randomizedCollectionGetRandom(RandomizedCollection* obj) {
    if (obj->size == 0) return -1;
    int random_index = rand() % obj->size;
    return obj->nums[random_index];
}

void randomizedCollectionFree(RandomizedCollection* obj) {
    free(obj->nums);
    free(obj->indices);
    free(obj->count);
    free(obj);
}

/**
 * Your RandomizedCollection struct will be instantiated and called as such:
 * RandomizedCollection* obj = randomizedCollectionCreate();
 * bool param_1 = randomizedCollectionInsert(obj, val);

 * bool param_2 = randomizedCollectionRemove(obj, val);

 * int param_3 = randomizedCollectionGetRandom(obj);

 * randomizedCollectionFree(obj);
*/