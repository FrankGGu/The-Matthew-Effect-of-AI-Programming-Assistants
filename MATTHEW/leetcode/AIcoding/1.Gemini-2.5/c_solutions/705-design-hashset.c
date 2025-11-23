#include <stdlib.h>
#include <stdbool.h>

#define MAX_KEY_VALUE 1000000
#define HASH_SET_ARRAY_SIZE (MAX_KEY_VALUE + 1)

typedef struct {
    char* data;
} MyHashSet;

MyHashSet* myHashSetCreate() {
    MyHashSet* obj = (MyHashSet*) malloc(sizeof(MyHashSet));
    if (obj == NULL) {
        return NULL;
    }

    obj->data = (char*) calloc(HASH_SET_ARRAY_SIZE, sizeof(char));
    if (obj->data == NULL) {
        free(obj);
        return NULL;
    }
    return obj;
}

void myHashSetAdd(MyHashSet* obj, int key) {
    if (obj != NULL && obj->data != NULL && key >= 0 && key <= MAX_KEY_VALUE) {
        obj->data[key] = 1;
    }
}

void myHashSetRemove(MyHashSet* obj, int key) {
    if (obj != NULL && obj->data != NULL && key >= 0 && key <= MAX_KEY_VALUE) {
        obj->data[key] = 0;
    }
}

bool myHashSetContains(MyHashSet* obj, int key) {
    if (obj != NULL && obj->data != NULL && key >= 0 && key <= MAX_KEY_VALUE) {
        return obj->data[key] == 1;
    }
    return false;
}

void myHashSetFree(MyHashSet* obj) {
    if (obj != NULL) {
        if (obj->data != NULL) {
            free(obj->data);
        }
        free(obj);
    }
}