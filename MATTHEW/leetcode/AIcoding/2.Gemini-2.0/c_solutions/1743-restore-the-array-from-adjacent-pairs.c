#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100001

int* restoreArray(int** adjacentPairs, int adjacentPairsSize, int* adjacentPairsColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (adjacentPairsSize + 1));
    int* degree = (int*)calloc(MAXN * 2, sizeof(int));
    int* adj[MAXN * 2];
    int* adj_size = (int*)calloc(MAXN * 2, sizeof(int));
    int first = 0;
    int offset = 100000;

    for (int i = 0; i < adjacentPairsSize; i++) {
        int u = adjacentPairs[i][0] + offset;
        int v = adjacentPairs[i][1] + offset;

        if (adj[u] == NULL) {
            adj[u] = (int*)malloc(sizeof(int) * 2);
        }
        if (adj[v] == NULL) {
            adj[v] = (int*)malloc(sizeof(int) * 2);
        }

        adj[u][adj_size[u]++] = v;
        adj[v][adj_size[v]++] = u;

        degree[u]++;
        degree[v]++;
    }

    for (int i = 0; i < MAXN * 2; i++) {
        if (degree[i] == 1) {
            first = i;
            break;
        }
    }

    result[0] = first - offset;
    int prev = -1;
    int curr = first;

    for (int i = 1; i <= adjacentPairsSize; i++) {
        for (int j = 0; j < adj_size[curr]; j++) {
            int neighbor = adj[curr][j];
            if (neighbor != prev) {
                result[i] = neighbor - offset;
                prev = curr;
                curr = neighbor;
                break;
            }
        }
    }

    *returnSize = adjacentPairsSize + 1;

    for (int i = 0; i < MAXN*2; i++) {
        if (adj[i] != NULL) {
            free(adj[i]);
        }
    }
    free(degree);
    free(adj_size);

    return result;
}