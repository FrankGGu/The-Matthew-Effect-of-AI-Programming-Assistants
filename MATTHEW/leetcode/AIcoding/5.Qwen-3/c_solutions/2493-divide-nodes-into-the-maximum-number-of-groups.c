#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int val;
    struct ListNode* next;
} ListNode;

typedef struct {
    int size;
    ListNode** buckets;
} HashTable;

HashTable* createHashTable(int size) {
    HashTable* ht = (HashTable*)malloc(sizeof(HashTable));
    ht->size = size;
    ht->buckets = (ListNode**)calloc(size, sizeof(ListNode*));
    return ht;
}

void freeHashTable(HashTable* ht) {
    for (int i = 0; i < ht->size; ++i) {
        ListNode* curr = ht->buckets[i];
        while (curr) {
            ListNode* next = curr->next;
            free(curr);
            curr = next;
        }
    }
    free(ht->buckets);
    free(ht);
}

void hashInsert(HashTable* ht, int key) {
    int index = key % ht->size;
    ListNode* node = (ListNode*)malloc(sizeof(ListNode));
    node->val = key;
    node->next = ht->buckets[index];
    ht->buckets[index] = node;
}

int hashContains(HashTable* ht, int key) {
    int index = key % ht->size;
    ListNode* curr = ht->buckets[index];
    while (curr) {
        if (curr->val == key) return 1;
        curr = curr->next;
    }
    return 0;
}

int bfs(int** graph, int n, int start, int* color) {
    int* queue = (int*)malloc(n * sizeof(int));
    int front = 0, rear = 0;
    queue[rear++] = start;
    color[start] = 0;
    int maxGroup = 0;
    while (front < rear) {
        int u = queue[front++];
        maxGroup = (maxGroup > color[u]) ? maxGroup : color[u];
        for (int v = 0; v < n; ++v) {
            if (graph[u][v] && color[v] == -1) {
                color[v] = color[u] + 1;
                queue[rear++] = v;
            }
        }
    }
    free(queue);
    return maxGroup + 1;
}

int isBipartite(int** graph, int n) {
    int* color = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) color[i] = -1;
    for (int i = 0; i < n; ++i) {
        if (color[i] == -1) {
            int* queue = (int*)malloc(n * sizeof(int));
            int front = 0, rear = 0;
            queue[rear++] = i;
            color[i] = 0;
            while (front < rear) {
                int u = queue[front++];
                for (int v = 0; v < n; ++v) {
                    if (graph[u][v]) {
                        if (color[v] == -1) {
                            color[v] = color[u] ^ 1;
                            queue[rear++] = v;
                        } else if (color[v] == color[u]) {
                            free(color);
                            free(queue);
                            return 0;
                        }
                    }
                }
            }
            free(queue);
        }
    }
    free(color);
    return 1;
}

int maxGroups(int** graph, int n) {
    if (!isBipartite(graph, n)) return -1;
    int* color = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) color[i] = -1;
    int maxGroup = 0;
    for (int i = 0; i < n; ++i) {
        if (color[i] == -1) {
            maxGroup = (maxGroup > bfs(graph, n, i, color)) ? maxGroup : bfs(graph, n, i, color);
        }
    }
    free(color);
    return maxGroup;
}