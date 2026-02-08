#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void dfs(int node, int* visited, int* componentSize, int n, int** adj, int* adjSize) {
    visited[node] = 1;
    (*componentSize)++;

    for (int i = 0; i < adjSize[node]; i++) {
        int neighbor = adj[node][i];
        if (!visited[neighbor]) {
            dfs(neighbor, visited, componentSize, n, adj, adjSize);
        }
    }
}

long long countPairs(int n, int** edges, int edgesSize, int* edgesColSize) {
    int* adjSize = (int*)calloc(n, sizeof(int));
    int** adj = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    long long unreachablePairs = 0;
    long long remainingNodes = n;

    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            int componentSize = 0;
            dfs(i, visited, &componentSize, n, adj, adjSize);
            unreachablePairs += (long long)componentSize * (remainingNodes - componentSize);
            remainingNodes -= componentSize;
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSize);
    free(visited);

    return unreachablePairs;
}