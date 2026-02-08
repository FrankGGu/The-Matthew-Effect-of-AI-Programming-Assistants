#include <stdio.h>
#include <stdlib.h>

int minOperations(int* grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];
    int* col = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        col[i] = grid[0][i];
    }
    for (int i = 1; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == col[j]) {
                continue;
            } else {
                int k = j;
                while (k < n && grid[i][k] != col[j]) {
                    k++;
                }
                if (k < n) {
                    int temp = col[j];
                    col[j] = col[k];
                    col[k] = temp;
                } else {
                    return -1;
                }
            }
        }
    }
    int operations = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[j][i] != col[i]) {
                operations++;
            }
        }
    }
    free(col);
    return operations;
}