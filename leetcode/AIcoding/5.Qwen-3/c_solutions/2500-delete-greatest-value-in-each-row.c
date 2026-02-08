#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int deleteGreatestValue(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int result = 0;

    for (int i = 0; i < rows; i++) {
        qsort(grid[i], cols, sizeof(int), compare);
    }

    for (int j = 0; j < cols; j++) {
        int max_val = 0;
        for (int i = 0; i < rows; i++) {
            if (grid[i][j] > max_val) {
                max_val = grid[i][j];
            }
        }
        result += max_val;
    }

    return result;
}