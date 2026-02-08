#include <stdlib.h>

int* restoreArray(int** adjacentPairs, int adjacentPairsSize, int* adjacentPairsColSize, int* returnSize) {
    int *degree = (int *)calloc(100001, sizeof(int));
    int **graph = (int **)malloc(100001 * sizeof(int *));
    for (int i = 0; i < 100001; i++) {
        graph[i] = (int *)malloc(100001 * sizeof(int));
    }

    for (int i = 0; i < adjacentPairsSize; i++) {
        int a = adjacentPairs[i][0], b = adjacentPairs[i][1];
        graph[a][degree[a]++] = b;
        graph[b][degree[b]++] = a;
    }

    int *result = (int *)malloc((adjacentPairsSize + 1) * sizeof(int));
    *returnSize = 0;
    for (int i = 0; i < 100001; i++) {
        if (degree[i] == 1) {
            result[(*returnSize)++] = i;
            break;
        }
    }

    for (int i = 1; i < *returnSize; i++) {
        int current = result[i - 1];
        for (int j = 0; j < degree[current]; j++) {
            int next = graph[current][j];
            if (degree[next] > 0) {
                result[(*returnSize)++] = next;
                degree[current] = 0;
                degree[next]--;
                break;
            }
        }
    }

    for (int i = 0; i < 100001; i++) {
        free(graph[i]);
    }
    free(graph);
    free(degree);

    return result;
}