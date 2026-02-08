#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int collectTheCoins(int* coins, int coinsSize, int** edges, int edgesSize, int* edgesColSize) {
    int n = coinsSize;
    int* degree = (int*)calloc(n, sizeof(int));
    bool* useful = (bool*)malloc(n * sizeof(bool));
    for (int i = 0; i < n; i++) {
        useful[i] = (coins[i] == 1);
    }

    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSizes = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSizes[u]++] = v;
        adj[v][adjSizes[v]++] = u;
        degree[u]++;
        degree[v]++;
    }

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1 && !useful[i]) {
            degree[i] = 0;
            for (int j = 0; j < adjSizes[i]; j++) {
                int neighbor = adj[i][j];
                degree[neighbor]--;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1 && useful[i]) {
            degree[i] = 0;
            for (int j = 0; j < adjSizes[i]; j++) {
                int neighbor = adj[i][j];
                degree[neighbor]--;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        if (degree[i] == 1 && useful[i]) {
            degree[i] = 0;
            for (int j = 0; j < adjSizes[i]; j++) {
                int neighbor = adj[i][j];
                degree[neighbor]--;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        if (degree[u] > 0 && degree[v] > 0) {
            count += 2;
        }
    }

    for(int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSizes);
    free(degree);
    free(useful);

    return count;
}