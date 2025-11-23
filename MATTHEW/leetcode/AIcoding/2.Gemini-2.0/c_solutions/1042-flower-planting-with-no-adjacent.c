#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* gardenNoAdj(int n, int** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = 0;
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    int* adj_sizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        adj_sizes[i] = 0;
        adj[i] = (int*)malloc(0 * sizeof(int));
    }

    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0] - 1;
        int v = paths[i][1] - 1;

        adj_sizes[u]++;
        adj[u] = (int*)realloc(adj[u], adj_sizes[u] * sizeof(int));
        adj[u][adj_sizes[u] - 1] = v;

        adj_sizes[v]++;
        adj[v] = (int*)realloc(adj[v], adj_sizes[v] * sizeof(int));
        adj[v][adj_sizes[v] - 1] = u;
    }

    for (int i = 0; i < n; i++) {
        int used[5] = {0};
        for (int j = 0; j < adj_sizes[i]; j++) {
            if (result[adj[i][j]] != 0) {
                used[result[adj[i][j]]] = 1;
            }
        }

        for (int j = 1; j <= 4; j++) {
            if (used[j] == 0) {
                result[i] = j;
                break;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);

    *returnSize = n;
    return result;
}