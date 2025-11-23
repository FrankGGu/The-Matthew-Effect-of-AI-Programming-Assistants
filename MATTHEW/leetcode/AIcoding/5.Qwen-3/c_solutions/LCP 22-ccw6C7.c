#include <stdio.h>
#include <stdlib.h>

int** myMalloc(int n, int m) {
    int** res = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        res[i] = (int*)malloc(m * sizeof(int));
    }
    return res;
}

void freeMem(int** grid, int n) {
    for (int i = 0; i < n; i++) {
        free(grid[i]);
    }
    free(grid);
}

int** drawChessboardGray(int n, int k) {
    int** result = myMalloc(n, n);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if ((i + j) % 2 == 0) {
                result[i][j] = 0;
            } else {
                result[i][j] = 1;
            }
        }
    }
    return result;
}