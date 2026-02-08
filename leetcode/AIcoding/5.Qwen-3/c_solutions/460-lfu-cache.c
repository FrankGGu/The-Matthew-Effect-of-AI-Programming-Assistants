#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int key;
    int value;
    int count;
    struct Node* next;
    struct Node* prev;
} Node;

typedef struct {
    int capacity;
    int size;
    int minCount;
    Node* head;
    Node* tail;
    Node** buckets;
} LFUCache;

LFUCache* lfuCacheCreate(int capacity) {
    LFUCache* cache = (LFUCache*)malloc(sizeof(LFUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->minCount = 0;
    cache->head = NULL;
    cache->tail = NULL;
    cache->buckets = (Node**)malloc((capacity + 2) * sizeof(Node*));
    for (int i = 0; i <= capacity + 1; ++i) {
        cache->buckets[i] = NULL;
    }
    return cache;
}

void removeNode(Node* node) {
    if (node->prev) {
        node->prev->next = node->next;
    } else {
        node->next->prev = NULL;
    }
    if (node->next) {
        node->next->prev = node->prev;
    } else {
        node->prev->next = NULL;
    }
}

void addNodeToHead(Node* node) {
    node->next = NULL;
    node->prev = NULL;
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node->prev = NULL;
    }
    if (!node->prev) {
        node->next = NULL;
    }
    if (!node->next) {
        node