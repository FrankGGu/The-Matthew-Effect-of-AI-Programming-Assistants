#include <stdio.h>
#include <stdlib.h>

int** generate(int n, int** returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(n * sizeof(int*));
    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc((i + 1) * sizeof(int));
        (*returnColumnSizes)[i] = i + 1;
        for (int j = 0; j <= i; j++) {
            result[i][j] = j + 1;
        }
    }
    return result;
}