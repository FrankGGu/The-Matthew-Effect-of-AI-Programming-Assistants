#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* neighbors;
    int size;
} Graph;

int dfs(int node, int parent, int* price, int* total, int* count, int* dp) {
    int res = price[node];
    for (int i = 0; i < count[node]; i++) {
        int neighbor = dp[node] ? dp[node][i] : 0;
        if (neighbor == parent) continue;
        res += dfs(neighbor, node, price, total, count, dp);
    }
    return res;
}

int minPrice(int n, int** reviews, int reviewsSize, int* price) {
    Graph* graph = (Graph*)malloc(n * sizeof(Graph));
    for (int i = 0; i < n; i++) {
        graph[i].neighbors = NULL;
        graph[i].size = 0;
    }

    for (int i = 0; i < reviewsSize; i++) {
        int u = reviews[i][0];
        int v = reviews[i][1];
        int* temp = (int*)realloc(graph[u].neighbors, (graph[u].size + 1) * sizeof(int));
        temp[graph[u].size++] = v;
        graph[u].neighbors = temp;

        temp = (int*)realloc(graph[v].neighbors, (graph[v].size + 1) * sizeof(int));
        temp[graph[v].size++] = u;
        graph[v].neighbors = temp;
    }

    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(graph[i].size * sizeof(int));
        memcpy(dp[i], graph[i].neighbors, graph[i].size * sizeof(int));
    }

    int total = 0;
    for (int i = 0; i < n; i++) {
        total += dfs(i, -1, price, &total, &count, dp);
    }

    free(dp);
    for (int i = 0; i < n; i++) {
        free(graph[i].neighbors);
    }
    free(graph);
    return total;
}