#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** constructProductMatrix(int** grid, int gridSize, int* gridColSize, int mod, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];
    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            long long product = 1;
            for (int row = 0; row < m; row++) {
                for (int col = 0; col < n; col++) {
                    if (row != i || col != j) {
                        product = (product * grid[row][col]) % mod;
                    }
                }
            }
            result[i][j] = (int)product;
        }
    }

    return result;
}