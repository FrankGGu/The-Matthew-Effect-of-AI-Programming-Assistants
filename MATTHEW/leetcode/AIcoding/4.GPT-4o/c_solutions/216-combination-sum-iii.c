#include <stdio.h>
#include <stdlib.h>

void backtrack(int k, int n, int start, int* path, int pathSize, int** result, int* returnSize) {
    if (k == 0 && n == 0) {
        result[*returnSize] = (int*)malloc(pathSize * sizeof(int));
        for (int i = 0; i < pathSize; i++) {
            result[*returnSize][i] = path[i];
        }
        (*returnSize)++;
        return;
    }
    for (int i = start; i < 10; i++) {
        if (i > n) break;
        path[pathSize] = i;
        backtrack(k - 1, n - i, i + 1, path, pathSize + 1, result, returnSize);
    }
}

int** combinationSum3(int k, int n, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(100 * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(100 * sizeof(int));
    int* path = (int*)malloc(k * sizeof(int));
    backtrack(k, n, 1, path, 0, result, returnSize);
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = k;
    }
    free(path);
    return result;
}