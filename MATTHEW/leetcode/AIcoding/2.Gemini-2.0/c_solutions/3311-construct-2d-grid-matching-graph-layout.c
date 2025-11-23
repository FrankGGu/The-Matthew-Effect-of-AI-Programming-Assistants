#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** construct2DArray(int** graph, int graphSize, int* graphColSize, int n, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(sizeof(int*) * n);
    *returnColumnSizes = (int*)malloc(sizeof(int) * n);
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc(sizeof(int) * n);
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            result[i][j] = 0;
        }
    }

    for (int i = 0; i < graphSize; i++) {
        for (int j = 0; j < graphColSize[i]; j++) {
            int u = i;
            int v = graph[i][j];
            result[u / n][u % n] = 1;
            result[v / n][v % n] = 1;
        }
    }

    return result;
}