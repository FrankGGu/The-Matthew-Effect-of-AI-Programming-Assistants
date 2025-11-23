#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubmatrices(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int count = 0;
    int* prefix = (int*)calloc(rows * cols, sizeof(int));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 'X') {
                prefix[i * cols + j] = 1;
            } else if (grid[i][j] == 'Y') {
                prefix[i * cols + j] = -1;
            } else {
                prefix[i * cols + j] = 0;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int sum = 0;
            for (int k = i; k < rows; k++) {
                for (int l = j; l < cols; l++) {
                    sum += prefix[k * cols + l];
                    if (sum == 0) {
                        count++;
                    }
                }
            }
        }
    }

    free(prefix);
    return count;
}