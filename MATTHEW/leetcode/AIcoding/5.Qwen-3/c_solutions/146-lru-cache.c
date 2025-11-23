#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct LRUCache {
    int capacity;
    int size;
    struct Node* head;
    struct Node* tail;
    struct HashTable* hash;
} LRUCache;

typedef struct Node {
    int key;
    int value;
    struct Node* prev;
    struct Node* next;
} Node;

typedef struct HashTable {
    int size;
    Node** buckets;
} HashTable;

Node* createNode(int key, int value) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->key = key;
    node->value = value;
    node->prev = NULL;
    node->next = NULL;
    return node;
}

void freeNode(Node* node) {
    free(node);
}

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = size;
    ht->buckets = (Node**)calloc(size, sizeof(Node*));
    return ht;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        Node* node = ht->buckets[i];
        while (node) {
            Node* next = node->next;
            freeNode(node);
            node = next;
        }
    }
    free(ht->buckets);
    free(ht);
}

int hashFunction(int key, int size) {
    return abs(key) % size;
}

void addNode(LRUCache* cache, Node* node) {
    node->next = cache->head;
    node->prev = NULL;
    if (cache->head) {
        cache->head->prev = node;
    }
    cache->head = node;
    if (!cache->tail) {
        cache->tail = node;
    }
}

void removeNode(LRUCache* cache, Node* node) {
    if (node->prev) {
        node->prev->next = node->next;
    } else {
        cache->head = node->next;
    }
    if (node->next) {
        node->next->prev = node->prev;
    } else {
        cache->tail = node->prev;
    }
}

void moveToHead(LRUCache* cache, Node* node) {
    removeNode(cache, node);
    addNode(cache, node);
}

int get(LRUCache* cache, int key) {
    int index = hashFunction(key, cache->hash->size);
    Node* node = cache->hash->buckets[index];
    while (node) {
        if (node->key == key) {
            moveToHead(cache, node);
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void put(LRUCache* cache, int key, int value) {
    int index = hashFunction(key, cache->hash->size);
    Node* node = cache->hash->buckets[index];
    while (node) {
        if (node->key == key) {
            node->value = value;
            moveToHead(cache, node);
            return;
        }
        node = node->next;
    }
    node = createNode(key, value);
    addNode(cache, node);
    cache->hash->buckets[index] = node;
    cache->size++;
    if (cache->size > cache->capacity) {
        Node* tail = cache->tail;
        int tailIndex = hashFunction(tail->key, cache->hash->size);
        Node* prevTail = tail->prev;
        if (prevTail) {
            prevTail->next = NULL;
        } else {
            cache->head = NULL;
        }
        cache->tail = prevTail;
        int indexTail = hashFunction(tail->key, cache->hash->size);
        Node* current = cache->hash->buckets[indexTail];
        Node* prev = NULL;
        while (current && current != tail) {
            prev = current;
            current = current->next;
        }
        if (prev) {
            prev->next = current->next;
        } else {
            cache->hash->buckets[indexTail] = current->next;
        }
        freeNode(tail);
        cache->size--;
    }
}

LRUCache* lruCacheCreate(int capacity) {
    LRUCache* cache = (LRUCache*)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->size = 0;
    cache->head = NULL;
    cache->tail = NULL;
    cache->hash = createHashTable(capacity * 2);
    return cache;
}

void lruCacheFree(LRUCache* obj) {
    freeHashTable(obj->hash);
    Node* current = obj->head;
    while (current) {
        Node* next = current->next;
        freeNode(current);
        current = next;
    }
    free(obj);
}