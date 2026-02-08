#include <stdio.h>
#include <stdlib.h>

int* findSubtreeSizes(char* s, int** edges, int n, int* edgesSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int* visited = (int*)malloc(n * sizeof(int));
    int* subtreeSize = (int*)malloc(n * sizeof(int));
    int* adj = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < n; i++) {
        adj[i] = -1;
    }

    for (int i = 0; i < *edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u] = v;
        adj[v] = u;
    }

    int dfs(int node, int parent) {
        visited[node] = 1;
        int size = 1;
        for (int i = 0; i < n; i++) {
            if (adj[i] == node && i != parent) {
                size += dfs(i, node);
            }
        }
        subtreeSize[node] = size;
        return size;
    }

    dfs(0, -1);

    for (int i = 0; i < n; i++) {
        result[i] = subtreeSize[i];
    }

    *returnSize = n;
    free(visited);
    free(adj);
    return result;
}