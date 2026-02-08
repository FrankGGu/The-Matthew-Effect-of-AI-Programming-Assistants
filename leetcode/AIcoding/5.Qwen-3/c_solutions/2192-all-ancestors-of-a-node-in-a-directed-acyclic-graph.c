#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct ListNode {
    int val;
    struct ListNode *next;
} ListNode;

typedef struct {
    int size;
    ListNode **table;
} Graph;

Graph* createGraph(int n) {
    Graph *g = (Graph*)malloc(sizeof(Graph));
    g->size = n;
    g->table = (ListNode**)malloc(n * sizeof(ListNode*));
    for (int i = 0; i < n; i++) {
        g->table[i] = NULL;
    }
    return g;
}

void addEdge(Graph *g, int u, int v) {
    ListNode *newNode = (ListNode*)malloc(sizeof(ListNode));
    newNode->val = v;
    newNode->next = g->table[u];
    g->table[u] = newNode;
}

void dfs(int node, int *visited, int *ancestor, Graph *g) {
    visited[node] = 1;
    ListNode *curr = g->table[node];
    while (curr) {
        if (!visited[curr->val]) {
            dfs(curr->val, visited, ancestor, g);
        }
        ancestor[curr->val] = 1;
        curr = curr->next;
    }
}

int* getAncestors(int n, int** edges, int edgesSize, int* edgesColSize, int* returnSize) {
    Graph *g = createGraph(n);
    for (int i = 0; i < edgesSize; i++) {
        addEdge(g, edges[i][0], edges[i][1]);
    }

    int *result = (int*)malloc(n * sizeof(int));
    int *temp = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        int *visited = (int*)calloc(n, sizeof(int));
        dfs(i, visited, temp, g);
        int count = 0;
        for (int j = 0; j < n; j++) {
            if (temp[j]) {
                result[*returnSize] = j;
                (*returnSize)++;
                count++;
            }
        }
        free(visited);
    }

    free(temp);
    return result;
}