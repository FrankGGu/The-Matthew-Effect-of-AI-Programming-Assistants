#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct DLinkedNode {
    int key, value;
    struct DLinkedNode *prev, *next;
} DLinkedNode;

typedef struct {
    int capacity, size;
    DLinkedNode *head, *tail;
    DLinkedNode **cache;
} LRUCache;

DLinkedNode* dLinkedNodeCreate(int key, int value) {
    DLinkedNode *node = (DLinkedNode*)malloc(sizeof(DLinkedNode));
    node->key = key;
    node->value = value;
    node->prev = node->next = NULL;
    return node;
}

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache *cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->head = dLinkedNodeCreate(0, 0);
    cache->tail = dLinkedNodeCreate(0, 0);
    cache->head->next = cache->tail;
    cache->tail->prev = cache->head;
    cache->cache = (DLinkedNode**)malloc(sizeof(DLinkedNode*) * 10001);
    for(int i=0; i<10001; i++){
        cache->cache[i] = NULL;
    }
    return cache;
}

int lRUCacheGet(LRUCache* obj, int key) {
    if (obj->cache[key] == NULL) {
        return -1;
    }
    DLinkedNode *node = obj->cache[key];
    node->prev->next = node->next;
    node->next->prev = node->prev;

    node->next = obj->head->next;
    node->prev = obj->head;
    obj->head->next->prev = node;
    obj->head->next = node;

    obj->cache[key] = node;
    return node->value;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    if (obj->cache[key] != NULL) {
        DLinkedNode *node = obj->cache[key];
        node->value = value;
        node->prev->next = node->next;
        node->next->prev = node->prev;

        node->next = obj->head->next;
        node->prev = obj->head;
        obj->head->next->prev = node;
        obj->head->next = node;

        obj->cache[key] = node;
    } else {
        DLinkedNode *node = dLinkedNodeCreate(key, value);
        node->next = obj->head->next;
        node->prev = obj->head;
        obj->head->next->prev = node;
        obj->head->next = node;
        obj->cache[key] = node;
        obj->size++;
        if (obj->size > obj->capacity) {
            DLinkedNode *removed = obj->tail->prev;
            obj->tail->prev = removed->prev;
            removed->prev->next = obj->tail;
            obj->cache[removed->key] = NULL;
            free(removed);
            obj->size--;
        }
    }
}

void lRUCacheFree(LRUCache* obj) {
    DLinkedNode *curr = obj->head;
    while (curr != NULL) {
        DLinkedNode *temp = curr->next;
        free(curr);
        curr = temp;
    }
    free(obj->cache);
    free(obj);
}