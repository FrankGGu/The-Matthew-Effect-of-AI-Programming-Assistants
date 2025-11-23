#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} MyHashSet;

MyHashSet* myHashSetCreate() {
    MyHashSet* obj = (MyHashSet*)malloc(sizeof(MyHashSet));
    obj->size = 0;
    obj->data = NULL;
    return obj;
}

void myHashSetAdd(MyHashSet* obj, int key) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->data[i] == key) return;
    }
    obj->data = (int*)realloc(obj->data, (obj->size + 1) * sizeof(int));
    obj->data[obj->size++] = key;
}

void myHashSetRemove(MyHashSet* obj, int key) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->data[i] == key) {
            for (int j = i; j < obj->size - 1; j++) {
                obj->data[j] = obj->data[j + 1];
            }
            obj->size--;
            obj->data = (int*)realloc(obj->data, obj->size * sizeof(int));
            return;
        }
    }
}

bool myHashSetContains(MyHashSet* obj, int key) {
    for (int i = 0; i < obj->size; i++) {
        if (obj->data[i] == key) return true;
    }
    return false;
}

void myHashSetFree(MyHashSet* obj) {
    free(obj->data);
    free(obj);
}