#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int val;
    int* neighbors;
    int size;
} Node;

typedef struct {
    int* nodes;
    int size;
} Graph;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int dfs(int node, int* visited, int* dp, Node* nodes, int* in_degree, int n) {
    if (visited[node]) return dp[node];
    visited[node] = 1;
    int max_profit = 0;
    for (int i = 0; i < nodes[node].size; i++) {
        int neighbor = nodes[node].neighbors[i];
        if (in_degree[neighbor] > 0) {
            max_profit = fmax(max_profit, dfs(neighbor, visited, dp, nodes, in_degree, n));
        }
    }
    dp[node] = max_profit + nodes[node].val;
    return dp[node];
}

int topologicalSort(int n, int** edges, int* edgeSize, int* values) {
    Node* nodes = (Node*)malloc(n * sizeof(Node));
    for (int i = 0; i < n; i++) {
        nodes[i].val = values[i];
        nodes[i].neighbors = NULL;
        nodes[i].size = 0;
    }

    int* in_degree = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < *edgeSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        nodes[u].size++;
        nodes[u].neighbors = (int*)realloc(nodes[u].neighbors, nodes[u].size * sizeof(int));
        nodes[u].neighbors[nodes[u].size - 1] = v;
        in_degree[v]++;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int* dp = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        if (in_degree[i] == 0) {
            dfs(i, visited, dp, nodes, in_degree, n);
        }
    }

    int max_profit = 0;
    for (int i = 0; i < n; i++) {
        max_profit = fmax(max_profit, dp[i]);
    }

    free(in_degree);
    free(visited);
    free(dp);
    for (int i = 0; i < n; i++) {
        free(nodes[i].neighbors);
    }
    free(nodes);

    return max_profit;
}