#include <stdio.h>
#include <stdlib.h>

int* gardenNoAdj(int n, int** paths, int pathsSize, int* pathsColSize, int* returnSize) {
    int* result = (int*)malloc(n * sizeof(int));
    int** graph = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        graph[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            graph[i][j] = 0;
        }
    }

    for (int i = 0; i < pathsSize; i++) {
        int u = paths[i][0] - 1;
        int v = paths[i][1] - 1;
        graph[u][v] = 1;
        graph[v][u] = 1;
    }

    for (int i = 0; i < n; i++) {
        int used[5] = {0};
        for (int j = 0; j < n; j++) {
            if (graph[i][j] == 1) {
                if (result[j] > 0) {
                    used[result[j]] = 1;
                }
            }
        }
        for (int k = 1; k <= 4; k++) {
            if (used[k] == 0) {
                result[i] = k;
                break;
            }
        }
    }

    *returnSize = n;
    return result;
}