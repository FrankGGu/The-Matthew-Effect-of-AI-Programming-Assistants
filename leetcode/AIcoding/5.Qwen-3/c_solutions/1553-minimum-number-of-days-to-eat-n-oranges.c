#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int key;
    int value;
    struct HashNode *next;
} HashNode;

typedef struct {
    HashNode **buckets;
    int size;
} HashMap;

HashMap* createHashMap(int size) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->size = size;
    map->buckets = (HashNode**)calloc(size, sizeof(HashNode*));
    return map;
}

unsigned long hash(int key) {
    return (unsigned long)key % 1000000007;
}

int get(HashMap *map, int key) {
    unsigned long index = hash(key);
    HashNode *node = map->buckets[index];
    while (node) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return -1;
}

void put(HashMap *map, int key, int value) {
    unsigned long index = hash(key);
    HashNode *node = map->buckets[index];
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
    node->next = map->buckets[index];
    map->buckets[index] = node;
}

int minDays(int n, HashMap *map) {
    if (n <= 1) return n;
    if (get(map, n) != -1) return get(map, n);

    int option1 = 1 + minDays(n / 2, map);
    int option2 = 1 + minDays(n / 3, map);
    int result = fmin(option1, option2);

    put(map, n, result);
    return result;
}

int minDays(int n) {
    HashMap *map = createHashMap(1000000);
    int result = minDays(n, map);
    free(map->buckets);
    free(map);
    return result;
}