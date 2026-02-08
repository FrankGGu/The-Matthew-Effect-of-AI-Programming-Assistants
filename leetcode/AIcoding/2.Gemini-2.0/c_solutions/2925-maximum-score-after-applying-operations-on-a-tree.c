#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int values[MAXN];
int visited[MAXN];
struct Node {
    int val;
    struct Node* next;
};
struct Node* adj[MAXN];

long long dfs(int u) {
    visited[u] = 1;
    long long sum = values[u];
    long long min_sum = 0;
    int is_leaf = 1;
    struct Node* curr = adj[u];
    while (curr != NULL) {
        int v = curr->val;
        if (!visited[v]) {
            is_leaf = 0;
            long long child_sum = dfs(v);
            min_sum += child_sum;
        }
        curr = curr->next;
    }
    if (is_leaf) {
        return values[u];
    } else {
        return (values[u] < min_sum) ? values[u] : min_sum;
    }
}

long long maximumScoreAfterOperations(int* values, int valuesSize, int** edges, int edgesSize, int* edgesColSize){
    for (int i = 0; i < valuesSize; i++) {
        adj[i] = NULL;
        visited[i] = 0;
        ::values[i] = values[i];
    }
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];

        struct Node* newNodeU = (struct Node*)malloc(sizeof(struct Node));
        newNodeU->val = v;
        newNodeU->next = adj[u];
        adj[u] = newNodeU;

        struct Node* newNodeV = (struct Node*)malloc(sizeof(struct Node));
        newNodeV->val = u;
        newNodeV->next = adj[v];
        adj[v] = newNodeV;
    }
    long long total_sum = 0;
    for(int i = 0; i < valuesSize; i++){
        total_sum += values[i];
    }
    long long min_sum = dfs(0);
    return total_sum - min_sum;
}