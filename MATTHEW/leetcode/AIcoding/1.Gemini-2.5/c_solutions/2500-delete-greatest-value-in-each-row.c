#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int deleteGreatestValue(int** grid, int gridSize, int* gridColSize) {
    int totalScore = 0;
    int numCols = gridColSize[0]; // All rows have the same number of columns

    // Sort each row in ascending order
    for (int i = 0; i < gridSize; i++) {
        qsort(grid[i], numCols, sizeof(int), compare);
    }

    // Iterate through columns to pick the maximum value from each column of sorted rows
    for (int j = 0; j < numCols; j++) {
        int maxValInCol = 0;
        for (int i = 0; i < gridSize; i++) {
            if (grid[i][j] > maxValInCol) {
                maxValInCol = grid[i][j];
            }
        }
        totalScore += maxValInCol;
    }

    return totalScore;
}