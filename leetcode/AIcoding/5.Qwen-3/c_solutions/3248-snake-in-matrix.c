#include <stdio.h>
#include <stdlib.h>

int** snakeMatrix(int n, int* returnSize, int** returnColumnSizes) {
    *returnSize = n;
    int** result = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = n;
        result[i] = (int*)malloc(n * sizeof(int));
    }

    int num = 1;
    for (int i = 0; i < n; i++) {
        if (i % 2 == 0) {
            for (int j = 0; j < n; j++) {
                result[i][j] = num++;
            }
        } else {
            for (int j = n - 1; j >= 0; j--) {
                result[i][j] = num++;
            }
        }
    }

    return result;
}