#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    int key, value, freq;
    struct Node *prev, *next;
} Node;

typedef struct List {
    int size;
    Node *head, *tail;
} List;

typedef struct {
    int capacity, size, minFreq;
    List *freqMap;
    Node **keyMap;
} LFUCache;

Node* createNode(int key, int value) {
    Node *node = (Node*)malloc(sizeof(Node));
    node->key = key;
    node->value = value;
    node->freq = 1;
    node->prev = node->next = NULL;
    return node;
}

List* createList() {
    List *list = (List*)malloc(sizeof(List));
    list->size = 0;
    list->head = (Node*)malloc(sizeof(Node));
    list->tail = (Node*)malloc(sizeof(Node));
    list->head->next = list->tail;
    list->tail->prev = list->head;
    return list;
}

void addNode(List *list, Node *node) {
    node->next = list->head->next;
    node->prev = list->head;
    list->head->next->prev = node;
    list->head->next = node;
    list->size++;
}

void removeNode(List *list, Node *node) {
    node->prev->next = node->next;
    node->next->prev = node->prev;
    list->size--;
}

Node* removeTail(List *list) {
    if (list->size > 0) {
        Node *node = list->tail->prev;
        removeNode(list, node);
        return node;
    }
    return NULL;
}

LFUCache* lFUCacheCreate(int capacity) {
    LFUCache *cache = (LFUCache*)malloc(sizeof(LFUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->minFreq = 0;
    cache->freqMap = (List*)malloc(sizeof(List) * (capacity + 1));
    cache->keyMap = (Node**)malloc(sizeof(Node*) * 10001);
    for (int i = 0; i <= capacity; i++) {
        cache->freqMap[i] = createList();
    }
    for (int i = 0; i <= 10000; i++) {
        cache->keyMap[i] = NULL;
    }
    return cache;
}

int lFUCacheGet(LFUCache* obj, int key) {
    if (obj->keyMap[key] == NULL) {
        return -1;
    }

    Node *node = obj->keyMap[key];
    int freq = node->freq;

    removeNode(obj->freqMap + freq, node);
    if (freq == obj->minFreq && obj->freqMap[freq]->size == 0) {
        obj->minFreq++;
    }

    node->freq++;
    addNode(obj->freqMap + node->freq, node);

    return node->value;
}

void lFUCachePut(LFUCache* obj, int key, int value) {
    if (obj->capacity <= 0) return;

    if (obj->keyMap[key] != NULL) {
        Node *node = obj->keyMap[key];
        node->value = value;
        lFUCacheGet(obj, key);
        return;
    }

    if (obj->size == obj->capacity) {
        Node *tail = removeTail(obj->freqMap + obj->minFreq);
        obj->keyMap[tail->key] = NULL;
        free(tail);
        obj->size--;
    }

    Node *node = createNode(key, value);
    obj->keyMap[key] = node;
    addNode(obj->freqMap + 1, node);
    obj->size++;
    obj->minFreq = 1;
}

void lFUCacheFree(LFUCache* obj) {
    for (int i = 0; i <= obj->capacity; i++) {
        Node *curr = obj->freqMap[i]->head;
        while (curr) {
            Node *next = curr->next;
            free(curr);
            curr = next;
        }
        free(obj->freqMap[i]);
    }
    free(obj->freqMap);
    free(obj->keyMap);
    free(obj);
}