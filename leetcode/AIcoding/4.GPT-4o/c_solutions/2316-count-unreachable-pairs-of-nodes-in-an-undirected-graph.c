#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *edges;
    int size;
} Graph;

void dfs(int node, Graph *graph, int *visited, int *count) {
    visited[node] = 1;
    (*count)++;
    for (int i = 0; i < graph[node].size; i++) {
        int neighbor = graph[node].edges[i];
        if (!visited[neighbor]) {
            dfs(neighbor, graph, visited, count);
        }
    }
}

long long countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    Graph *graph = malloc(n * sizeof(Graph));
    for (int i = 0; i < n; i++) {
        graph[i].edges = malloc(n * sizeof(int));
        graph[i].size = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        graph[edges[i][0]].edges[graph[edges[i][0]].size++] = edges[i][1];
        graph[edges[i][1]].edges[graph[edges[i][1]].size++] = edges[i][0];
    }

    int *visited = calloc(n, sizeof(int));
    long long result = 0;
    long long totalNodes = 0;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int count = 0;
            dfs(i, graph, visited, &count);
            result += count * totalNodes;
            totalNodes += count;
        }
    }

    for (int i = 0; i < n; i++) {
        free(graph[i].edges);
    }
    free(graph);
    free(visited);

    return result;
}