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
    Node** hash;
} LRUCache;

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache* cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->head = NULL;
    cache->tail = NULL;
    cache->hash = (Node**)malloc((capacity + 1) * sizeof(Node*));
    for (int i = 0; i <= capacity; i++) {
        cache->hash[i] = NULL;
    }
    return cache;
}

void removeNode(Node* node) {
    if (node->prev) {
        node->prev->next = node->next;
    } else {
        return;
    }
    if (node->next) {
        node->next->prev = node->prev;
    } else {
        return;
    }
}

void addNodeToHead(Node* node) {
    node->next = NULL;
    node->prev = NULL;
    if (!node->prev && !node->next) {
        node->prev = NULL;
        node->next = NULL;
    }
    if (node->prev) {
        node->prev->next = node;
    }
    if (node->next) {
        node->next->prev = node;
    }
    if (!node->prev) {
        node->prev = NULL;
    }
    if (!node->next) {
        node->next = NULL;
    }
}

int lRUCacheGet(LRUCache* obj, int key) {
    if (obj->hash[key] == NULL) {
        return -1;
    }
    Node* node = obj->hash[key];
    removeNode(node);
    addNodeToHead(node);
    return node->value;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    if (obj->hash[key] != NULL) {
        Node* node = obj->hash[key];
        node->value = value;
        removeNode(node);
        addNodeToHead(node);
        return;
    }
    Node* new_node = (Node*)malloc(sizeof(Node));
    new_node->key = key;
    new_node->value = value;
    new_node->prev = NULL;
    new_node->next = NULL;
    addNodeToHead(new_node);
    obj->hash[key] = new_node;
    obj->size++;
    if (obj->size > obj->capacity) {
        Node* tail_node = obj->tail;
        if (tail_node) {
            removeNode(tail_node);
            obj->hash[tail_node->key] = NULL;
            free(tail_node);
            obj->size--;
        }
    }
}

void lRUCacheFree(LRUCache* obj) {
    Node* current = obj->head;
    while (current) {
        Node* next = current->next;
        free(current);
        current = next;
    }
    free(obj->hash);
    free(obj);
}