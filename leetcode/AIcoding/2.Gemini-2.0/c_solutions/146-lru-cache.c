#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int key;
    int value;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct {
    int capacity;
    int size;
    Node* head;
    Node* tail;
    Node** map;
} LRUCache;

Node* createNode(int key, int value) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->key = key;
    node->value = value;
    node->prev = NULL;
    node->next = NULL;
    return node;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->head = NULL;
    cache->tail = NULL;
    cache->map = (Node**)malloc(capacity * sizeof(Node*));
    for (int i = 0; i < capacity; i++) {
        cache->map[i] = NULL;
    }
    return cache;
}

int lRUCacheGet(LRUCache* obj, int key) {
    int index = key % obj->capacity;
    if (index < 0) index += obj->capacity;

    Node* node = obj->map[index];
    while (node != NULL) {
        if (node->key == key) {
            if (node == obj->head) {
                return node->value;
            }
            if (node == obj->tail) {
                obj->tail = node->prev;
                obj->tail->next = NULL;
            } else {
                node->prev->next = node->next;
                node->next->prev = node->prev;
            }
            node->next = obj->head;
            node->prev = NULL;
            if (obj->head != NULL) {
                obj->head->prev = node;
            }
            obj->head = node;
            if (obj->tail == NULL) {
                obj->tail = node;
            }
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    int index = key % obj->capacity;
    if (index < 0) index += obj->capacity;

    Node* node = obj->map[index];
    Node* prev = NULL;
    while (node != NULL) {
        if (node->key == key) {
            node->value = value;
            if (node == obj->head) {
                return;
            }
            if (node == obj->tail) {
                obj->tail = node->prev;
                obj->tail->next = NULL;
            } else {
                node->prev->next = node->next;
                node->next->prev = node->prev;
            }
            node->next = obj->head;
            node->prev = NULL;
            obj->head->prev = node;
            obj->head = node;
            return;
        }
        prev = node;
        node = node->next;
    }

    Node* newNode = createNode(key, value);
    if (obj->size == obj->capacity) {
        int tailIndex = obj->tail->key % obj->capacity;
        if (tailIndex < 0) tailIndex += obj->capacity;

        Node* temp = obj->map[tailIndex];
        Node* tailPrev = NULL;
        while(temp != NULL && temp != obj->tail){
            tailPrev = temp;
            temp = temp->next;
        }

        if(tailPrev != NULL){
            tailPrev->next = obj->tail->next;
        } else {
            obj->map[tailIndex] = obj->tail->next;
        }

        Node* toFree = obj->tail;
        obj->tail = obj->tail->prev;
        if (obj->tail != NULL) {
            obj->tail->next = NULL;
        }
        free(toFree);
        obj->size--;
        if(obj->size == 0){
            obj->head = NULL;
        }
    }

    newNode->next = obj->head;
    if (obj->head != NULL) {
        obj->head->prev = newNode;
    }
    obj->head = newNode;

    if (obj->tail == NULL) {
        obj->tail = newNode;
    }

    if(obj->map[index] == NULL){
        obj->map[index] = newNode;
    } else {
        node = obj->map[index];
        while(node->next != NULL){
            node = node->next;
        }
        node->next = newNode;
    }

    obj->size++;
}

void lRUCacheFree(LRUCache* obj) {
    Node* current = obj->head;
    while (current != NULL) {
        Node* next = current->next;
        free(current);
        current = next;
    }
    free(obj->map);
    free(obj);
}