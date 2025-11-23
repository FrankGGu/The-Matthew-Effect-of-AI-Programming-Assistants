#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int value;
    struct Node* next;
} Node;

typedef struct {
    Node** table;
    int capacity;
    int size;
} MyHashMap;

Node* createNode(int key, int value) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = key;
    newNode->value = value;
    newNode->next = NULL;
    return newNode;
}

MyHashMap* myHashMapCreate() {
    MyHashMap* obj = (MyHashMap*)malloc(sizeof(MyHashMap));
    obj->capacity = 10000;
    obj->size = 0;
    obj->table = (Node**)calloc(obj->capacity, sizeof(Node*));
    return obj;
}

void myHashMapPut(MyHashMap* obj, int key, int value) {
    int index = key % obj->capacity;
    Node* current = obj->table[index];
    while (current != NULL) {
        if (current->key == key) {
            current->value = value;
            return;
        }
        current = current->next;
    }
    Node* newNode = createNode(key, value);
    newNode->next = obj->table[index];
    obj->table[index] = newNode;
    obj->size++;
}

int myHashMapGet(MyHashMap* obj, int key) {
    int index = key % obj->capacity;
    Node* current = obj->table[index];
    while (current != NULL) {
        if (current->key == key) {
            return current->value;
        }
        current = current->next;
    }
    return -1;
}

void myHashMapRemove(MyHashMap* obj, int key) {
    int index = key % obj->capacity;
    Node* current = obj->table[index];
    Node* prev = NULL;
    while (current != NULL) {
        if (current->key == key) {
            if (prev == NULL) {
                obj->table[index] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            obj->size--;
            return;
        }
        prev = current;
        current = current->next;
    }
}

void myHashMapFree(MyHashMap* obj) {
    for (int i = 0; i < obj->capacity; i++) {
        Node* current = obj->table[i];
        while (current != NULL) {
            Node* temp = current;
            current = current->next;
            free(temp);
        }
    }
    free(obj->table);
    free(obj);
}