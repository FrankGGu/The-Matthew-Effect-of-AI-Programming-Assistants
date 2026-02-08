#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int* neighbors;
    int size;
} Node;

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int dfs(int node, int parent, int** graph, int n, int power, int* result) {
    int max_time = 0;
    for (int i = 0; i < n; i++) {
        if (graph[node][i] == 1 && i != parent) {
            int child_time = dfs(i, node, graph, n, power, result);
            max_time = max(max_time, child_time);
        }
    }
    return max_time + 2 * power;
}

int networkBecomesIdle(int** edges, int edgesSize, int* edgesColSize, int power) {
    int n = edgesSize + 1;
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)calloc(n, sizeof(int));
    }
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        graph[u][v] = 1;
        graph[v][u] = 1;
    }
    int result = 0;
    for (int i = 0; i < n; i++) {
        int time = dfs(i, -1, graph, n, power, &result);
        result = max(result, time);
    }
    for (int i = 0; i < n; i++) {
        free(graph[i]);
    }
    free(graph);
    return result;
}