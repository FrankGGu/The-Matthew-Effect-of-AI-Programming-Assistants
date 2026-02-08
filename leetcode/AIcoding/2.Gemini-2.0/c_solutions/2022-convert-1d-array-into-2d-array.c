#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** construct2DArray(int* original, int originalSize, int m, int n, int* returnSize, int** returnColumnSizes) {
    if (m * n != originalSize) {
        *returnSize = 0;
        return NULL;
    }

    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
        for (int j = 0; j < n; j++) {
            result[i][j] = original[i * n + j];
        }
    }

    return result;
}