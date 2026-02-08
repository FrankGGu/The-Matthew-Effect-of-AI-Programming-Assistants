#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int** largestLocal(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int n = gridSize;
    int res_n = n - 2;

    *returnSize = res_n;

    *returnColumnSizes = (int*)malloc(res_n * sizeof(int));
    for (int i = 0; i < res_n; i++) {
        (*returnColumnSizes)[i] = res_n;
    }

    int** result = (int**)malloc(res_n * sizeof(int*));
    for (int i = 0; i < res_n; i++) {
        result[i] = (int*)malloc(res_n * sizeof(int));
    }

    for (int i = 0; i < res_n; i++) {
        for (int j = 0; j < res_n; j++) {
            int max_val = INT_MIN; 

            for (int row_offset = 0; row_offset < 3; row_offset++) {
                for (int col_offset = 0; col_offset < 3; col_offset++) {
                    max_val = max(max_val, grid[i + row_offset][j + col_offset]);
                }
            }
            result[i][j] = max_val;
        }
    }

    return result;
}