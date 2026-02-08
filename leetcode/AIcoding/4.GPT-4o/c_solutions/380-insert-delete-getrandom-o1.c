#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int *data;
    int *index;
    int size;
    int capacity;
} RandomizedSet;

RandomizedSet* randomizedSetCreate() {
    RandomizedSet *set = (RandomizedSet *)malloc(sizeof(RandomizedSet));
    set->size = 0;
    set->capacity = 10;
    set->data = (int *)malloc(set->capacity * sizeof(int));
    set->index = (int *)malloc(set->capacity * sizeof(int));
    for (int i = 0; i < set->capacity; i++) {
        set->index[i] = -1;
    }
    return set;
}

bool randomizedSetInsert(RandomizedSet* obj, int val) {
    if (obj->index[val] != -1) return false;
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->data = (int *)realloc(obj->data, obj->capacity * sizeof(int));
        obj->index = (int *)realloc(obj->index, obj->capacity * sizeof(int));
        for (int i = obj->size; i < obj->capacity; i++) {
            obj->index[i] = -1;
        }
    }
    obj->data[obj->size] = val;
    obj->index[val] = obj->size++;
    return true;
}

bool randomizedSetRemove(RandomizedSet* obj, int val) {
    if (obj->index[val] == -1) return false;
    int index = obj->index[val];
    obj->data[index] = obj->data[--obj->size];
    obj->index[obj->data[index]] = index;
    obj->index[val] = -1;
    return true;
}

int randomizedSetGetRandom(RandomizedSet* obj) {
    return obj->data[rand() % obj->size];
}

void randomizedSetFree(RandomizedSet* obj) {
    free(obj->data);
    free(obj->index);
    free(obj);
}