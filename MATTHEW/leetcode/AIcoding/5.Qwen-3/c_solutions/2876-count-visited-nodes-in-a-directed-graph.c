#include <stdio.h>
#include <stdlib.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

typedef struct {
    int size;
    ListNode **table;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable *h = (HashTable*)malloc(sizeof(HashTable));
    h->size = size;
    h->table = (ListNode**)calloc(size, sizeof(ListNode*));
    return h;
}

void freeHashTable(HashTable *h) {
    for (int i = 0; i < h->size; i++) {
        ListNode *curr = h->table[i];
        while (curr) {
            ListNode *next = curr->next;
            free(curr);
            curr = next;
        }
    }
    free(h->table);
    free(h);
}

int hashFunction(int key, int size) {
    return abs(key) % size;
}

void insertIntoHash(HashTable *h, int key) {
    int index = hashFunction(key, h->size);
    ListNode *newNode = (ListNode*)malloc(sizeof(ListNode));
    newNode->val = key;
    newNode->next = h->table[index];
    h->table[index] = newNode;
}

int containsInHash(HashTable *h, int key) {
    int index = hashFunction(key, h->size);
    ListNode *curr = h->table[index];
    while (curr) {
        if (curr->val == key) return 1;
        curr = curr->next;
    }
    return 0;
}

int dfs(int node, int *visited, int *inStack, int *count, int **adjList, int n, HashTable *hash) {
    if (visited[node]) {
        return 0;
    }
    if (inStack[node]) {
        return 0;
    }
    visited[node] = 1;
    inStack[node] = 1;
    int total = 1;
    for (int i = 0; adjList[node][i] != -1; i++) {
        int next = adjList[node][i];
        total += dfs(next, visited, inStack, count, adjList, n, hash);
    }
    inStack[node] = 0;
    return total;
}

int* countVisitedNodes(int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    int n = edgesSize;
    int **adjList = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adjList[i] = (int*)malloc((edgesColSize[i] + 1) * sizeof(int));
        for (int j = 0; j < edgesColSize[i]; j++) {
            adjList[i][j] = edges[i][j];
        }
        adjList[i][edgesColSize[i]] = -1;
    }

    int *result = (int*)malloc(n * sizeof(int));
    int *visited = (int*)calloc(n, sizeof(int));
    int *inStack = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int count = 0;
            HashTable *hash = createHashTable(n);
            int *stack = (int*)malloc(n * sizeof(int));
            int top = -1;
            int current = i;
            while (1) {
                if (visited[current]) {
                    if (containsInHash(hash, current)) {
                        int idx = -1;
                        for (int k = 0; k <= top; k++) {
                            if (stack[k] == current) {
                                idx = k;
                                break;
                            }
                        }
                        for (int k = idx; k <= top; k++) {
                            result[stack[k]] = top - idx + 1;
                        }
                    }
                    break;
                }
                visited[current] = 1;
                inStack[current] = 1;
                insertIntoHash(hash, current);
                stack[++top] = current;
                current = adjList[current][0];
            }
            free(stack);
            freeHashTable(hash);
        }
    }

    *returnSize = n;
    return result;
}