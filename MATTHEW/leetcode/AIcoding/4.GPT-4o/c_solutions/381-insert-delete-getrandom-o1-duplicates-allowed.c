#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

typedef struct {
    int *arr;
    int *indices;
    int size;
    int capacity;
} RandomizedCollection;

RandomizedCollection* randomizedCollectionCreate() {
    RandomizedCollection *collection = (RandomizedCollection *)malloc(sizeof(RandomizedCollection));
    collection->arr = (int *)malloc(10 * sizeof(int));
    collection->indices = (int *)malloc(10 * sizeof(int));
    collection->size = 0;
    collection->capacity = 10;
    return collection;
}

bool randomizedCollectionInsert(RandomizedCollection* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->arr = (int *)realloc(obj->arr, obj->capacity * sizeof(int));
        obj->indices = (int *)realloc(obj->indices, obj->capacity * sizeof(int));
    }
    obj->arr[obj->size] = val;
    obj->indices[obj->size] = obj->size;
    obj->size++;
    return true;
}

bool randomizationCollectionRemove(RandomizedCollection* obj, int val) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->arr[i] == val) {
            obj->arr[i] = obj->arr[obj->size - 1];
            obj->size--;
            return true;
        }
    }
    return false;
}

int randomizedCollectionGetRandom(RandomizedCollection* obj) {
    return obj->arr[rand() % obj->size];
}

void randomizedCollectionFree(RandomizedCollection* obj) {
    free(obj->arr);
    free(obj->indices);
    free(obj);
}