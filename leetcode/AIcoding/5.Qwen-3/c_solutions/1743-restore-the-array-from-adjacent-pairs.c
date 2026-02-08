#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int key;
    int val;
} Pair;

typedef struct Node {
    int val;
    struct Node* next;
} Node;

typedef struct {
    Node** buckets;
    int size;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->buckets = (Node**)malloc(size * sizeof(Node*));
    for (int i = 0; i < size; i++) {
        ht->buckets[i] = NULL;
    }
    ht->size = size;
    return ht;
}

void put(HashTable* ht, int key, int value) {
    int index = abs(key) % ht->size;
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = value;
    node->next = ht->buckets[index];
    ht->buckets[index] = node;
}

int get(HashTable* ht, int key) {
    int index = abs(key) % ht->size;
    Node* current = ht->buckets[index];
    while (current) {
        if (current->val == key) {
            return current->val;
        }
        current = current->next;
    }
    return -1;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; i++) {
        Node* current = ht->buckets[i];
        while (current) {
            Node* next = current->next;
            free(current);
            current = next;
        }
    }
    free(ht->buckets);
    free(ht);
}

int* restoreArray(int** adjacentPairs, int adjacentPairsSize, int* adjacentPairsColSize, int* returnSize) {
    int n = adjacentPairsSize + 1;
    *returnSize = n;
    int* result = (int*)malloc(n * sizeof(int));

    HashTable* ht = createHashTable(10000);

    for (int i = 0; i < adjacentPairsSize; i++) {
        int a = adjacentPairs[i][0];
        int b = adjacentPairs[i][1];
        put(ht, a, b);
        put(ht, b, a);
    }

    int start = -1;
    for (int i = 0; i < adjacentPairsSize; i++) {
        int a = adjacentPairs[i][0];
        int count = 0;
        int index = abs(a) % ht->size;
        Node* current = ht->buckets[index];
        while (current) {
            count++;
            current = current->next;
        }
        if (count == 1) {
            start = a;
            break;
        }
    }

    result[0] = start;
    int prev = -1;
    for (int i = 1; i < n; i++) {
        int curr = get(ht, result[i - 1]);
        if (curr != prev) {
            result[i] = curr;
            prev = result[i - 1];
        } else {
            prev = result[i - 1];
            result[i] = get(ht, result[i - 1]);
        }
    }

    freeHashTable(ht);
    return result;
}