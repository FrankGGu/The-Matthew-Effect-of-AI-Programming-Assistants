#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* table;
    int size;
} MyHashSet;

MyHashSet* myHashSetCreate() {
    MyHashSet* obj = (MyHashSet*)malloc(sizeof(MyHashSet));
    obj->size = 10000;
    obj->table = (int*)malloc(sizeof(int) * obj->size);
    for (int i = 0; i < obj->size; i++) {
        obj->table[i] = -1;
    }
    return obj;
}

void myHashSetAdd(MyHashSet* obj, int key) {
    int index = key % obj->size;
    int curr = index;
    while (obj->table[curr] != -1 && obj->table[curr] != key) {
        curr = (curr + 1) % obj->size;
        if (curr == index) return;
    }
    obj->table[curr] = key;
}

void myHashSetRemove(MyHashSet* obj, int key) {
    int index = key % obj->size;
    int curr = index;
    while (obj->table[curr] != -1) {
        if (obj->table[curr] == key) {
            obj->table[curr] = -2;
            return;
        }
        curr = (curr + 1) % obj->size;
        if (curr == index) return;
    }
}

bool myHashSetContains(MyHashSet* obj, int key) {
    int index = key % obj->size;
    int curr = index;
    while (obj->table[curr] != -1) {
        if (obj->table[curr] == key) {
            return true;
        }
        curr = (curr + 1) % obj->size;
        if (curr == index) return false;
    }
    return false;
}

void myHashSetFree(MyHashSet* obj) {
    free(obj->table);
    free(obj);
}