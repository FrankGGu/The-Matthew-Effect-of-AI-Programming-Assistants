#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int count;
    int* points;
} PointList;

typedef struct {
    int key;
    int value;
    struct HashNode* next;
} HashNode;

typedef struct {
    HashNode** table;
    int size;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = size;
    ht->table = (HashNode**)calloc(size, sizeof(HashNode*));
    return ht;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        HashNode* node = ht->table[i];
        while (node) {
            HashNode* next = node->next;
            free(node);
            node = next;
        }
    }
    free(ht->table);
    free(ht);
}

void hashInsert(HashTable* ht, int key, int value) {
    int index = abs(key) % ht->size;
    HashNode* node = (HashNode*)malloc(sizeof(HashNode));
    node->key = key;
    node->value = value;
    node->next = ht->table[index];
    ht->table[index] = node;
}

int hashGet(HashTable* ht, int key) {
    int index = abs(key) % ht->size;
    HashNode* node = ht->table[index];
    while (node) {
        if (node->key == key) {
            return node->value;
        }
        node = node->next;
    }
    return 0;
}

void hashDelete(HashTable* ht, int key) {
    int index = abs(key) % ht->size;
    HashNode* node = ht->table[index];
    HashNode* prev = NULL;
    while (node) {
        if (node->key == key) {
            if (prev) {
                prev->next = node->next;
            } else {
                ht->table[index] = node->next;
            }
            free(node);
            return;
        }
        prev = node;
        node = node->next;
    }
}

PointList* getPoints(int** queries, int queriesSize) {
    PointList* pl = (PointList*)malloc(sizeof(PointList));
    pl->count = 0;
    pl->points = (int*)malloc(queriesSize * 2 * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        pl->points[pl->count++] = queries[i][0];
        pl->points[pl->count++] = queries[i][1];
    }
    return pl;
}

int* gridIllumination(int** queries, int queriesSize, int* queriesColSize, int** bricks, int bricksSize, int* bricksColSize, int* returnSize) {
    int n = bricksSize;
    int m = queriesSize;
    int* result = (int*)malloc(m * sizeof(int));
    HashTable* row = createHashTable(10000);
    HashTable* col = createHashTable(10000);
    HashTable* diag1 = createHashTable(10000);
    HashTable* diag2 = createHashTable(10000);
    HashTable* light = createHashTable(10000);

    for (int i = 0; i < bricksSize; i++) {
        int x = bricks[i][0];
        int y = bricks[i][1];
        hashInsert(row, x, hashGet(row, x) + 1);
        hashInsert(col, y, hashGet(col, y) + 1);
        hashInsert(diag1, x - y, hashGet(diag1, x - y) + 1);
        hashInsert(diag2, x + y, hashGet(diag2, x + y) + 1);
        hashInsert(light, x * 10000 + y, hashGet(light, x * 10000 + y) + 1);
    }

    for (int i = 0; i < m; i++) {
        int x = queries[i][0];
        int y = queries[i][1];
        if (hashGet(row, x) > 0 || hashGet(col, y) > 0 || hashGet(diag1, x - y) > 0 || hashGet(diag2, x + y) > 0) {
            result[i] = 1;
        } else {
            result[i] = 0;
        }

        if (hashGet(light, x * 10000 + y) > 0) {
            hashDelete(light, x * 10000 + y);
            hashDelete(row, x);
            hashDelete(col, y);
            hashDelete(diag1, x - y);
            hashDelete(diag2, x + y);
        }
    }

    *returnSize = m;
    return result;
}