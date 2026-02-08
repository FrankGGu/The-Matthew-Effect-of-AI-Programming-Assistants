#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** buckets;
    int size;
} MyHashMap;

MyHashMap* myHashMapCreate() {
    MyHashMap* obj = (MyHashMap*)malloc(sizeof(MyHashMap));
    obj->size = 1000;
    obj->buckets = (HashNode**)calloc(obj->size, sizeof(HashNode*));
    return obj;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    int index = key % obj->size;
    HashNode* node = obj->buckets[index];
    while (node) {
        if (node->key == key) {
            node->value = value;
            return;
        }
        node = node->next;
    }
    node = (HashNode*)malloc(sizeof(HashNode));
    node->key = key;
    node->value = value;
    node->next = obj->buckets[index];
    obj->buckets[index] = node;
}

int myHashMapGet(MyHashMap* obj, int key) {
    int index = key % obj->size;
    HashNode* node = obj->buckets[index];
    while (node) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    int index = key % obj->size;
    HashNode* node = obj->buckets[index];
    HashNode* prev = NULL;
    while (node) {
        if (node->key == key) {
            if (prev) {
                prev->next = node->next;
            } else {
                obj->buckets[index] = node->next;
            }
            free(node);
            return;
        }
        prev = node;
        node = node->next;
    }
}

void myHashMapFree(MyHashMap* obj) {
    for (int i = 0; i < obj->size; i++) {
        HashNode* node = obj->buckets[i];
        while (node) {
            HashNode* temp = node;
            node = node->next;
            free(temp);
        }
    }
    free(obj->buckets);
    free(obj);
}