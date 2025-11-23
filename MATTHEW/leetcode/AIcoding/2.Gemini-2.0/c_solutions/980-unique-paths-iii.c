#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int uniquePathsIIIHelper(int** grid, int rows, int cols, int row, int col, int steps, int totalSteps) {
    if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == -1) {
        return 0;
    }

    if (grid[row][col] == 2) {
        if (steps == totalSteps) {
            return 1;
        } else {
            return 0;
        }
    }

    grid[row][col] = -1;
    int paths = uniquePathsIIIHelper(grid, rows, cols, row + 1, col, steps + 1, totalSteps) +
                uniquePathsIIIHelper(grid, rows, cols, row - 1, col, steps + 1, totalSteps) +
                uniquePathsIIIHelper(grid, rows, cols, row, col + 1, steps + 1, totalSteps) +
                uniquePathsIIIHelper(grid, rows, cols, row, col - 1, steps + 1, totalSteps);
    grid[row][col] = 0;

    return paths;
}

int uniquePathsIII(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int startRow = -1, startCol = -1;
    int totalSteps = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                startRow = i;
                startCol = j;
            }
            if (grid[i][j] != -1) {
                totalSteps++;
            }
        }
    }

    return uniquePathsIIIHelper(grid, rows, cols, startRow, startCol, 1, totalSteps);
}