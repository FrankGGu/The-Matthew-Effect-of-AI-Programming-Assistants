#include <stdlib.h>
#include <stdbool.h>

#define HASH_SIZE 2069 // A prime number for better distribution

typedef struct Node {
    int key;
    int value;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} MyHashMap;

MyHashMap* myHashMapCreate() {
    MyHashMap* obj = (MyHashMap*)malloc(sizeof(MyHashMap));
    obj->size = HASH_SIZE;
    obj->buckets = (Node**)calloc(obj->size, sizeof(Node*));
    return obj;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    int index = key % obj->size;
    Node* current = obj->buckets[index];

    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }

    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = obj->buckets[index];
    obj->buckets[index] = newNode;
}

int myHashMapGet(MyHashMap* obj, int key) {
    int index = key % obj->size;
    Node* current = obj->buckets[index];

    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }

    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    int index = key % obj->size;
    Node* current = obj->buckets[index];
    Node* prev = NULL;

    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) { // Node to remove is the head
                obj->buckets[index] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            return;
        }
        prev = current;
        current = current->next;
    }
}

void myHashMapFree(MyHashMap* obj) {
    if (obj == NULL) {
        return;
    }

    for (int i = 0; i < obj->size; i++) {
        Node* current = obj->buckets[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(obj->buckets);
    free(obj);
}