#include <stdio.h>
#include <stdlib.h>

int** gridPartition(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    int totalSum = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            totalSum += grid[i][j];
        }
    }

    if (totalSum % k != 0) {
        return NULL;
    }

    int target = totalSum / k;
    int currentSum = 0;
    int row = 0;
    int col = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (currentSum + grid[i][j] > target) {
                row++;
                col = 0;
                currentSum = 0;
            }
            result[row][col++] = grid[i][j];
            currentSum += grid[i][j];
        }
    }

    return result;
}