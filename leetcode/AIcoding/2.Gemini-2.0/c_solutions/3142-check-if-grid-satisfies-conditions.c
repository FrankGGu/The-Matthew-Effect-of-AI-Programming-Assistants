#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool checkEqualRow(int* row, int rowSize) {
    for (int i = 1; i < rowSize; i++) {
        if (row[i] != row[0]) {
            return false;
        }
    }
    return true;
}

bool checkEqualCol(int** grid, int gridSize, int col) {
    for (int i = 1; i < gridSize; i++) {
        if (grid[i][col] != grid[0][col]) {
            return false;
        }
    }
    return true;
}

bool checkEqual(int** grid, int gridSize, int* gridColSize) {
    int firstVal = grid[0][0];

    bool rowEqual = true;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] != firstVal) {
                rowEqual = false;
                break;
            }
        }
        if (!rowEqual) break;
    }

    if (rowEqual) return true;

    for (int i = 0; i < gridSize; i++) {
        if (checkEqualRow(grid[i], gridColSize[i])) return true;
    }

    for (int j = 0; j < gridColSize[0]; j++) {
        if (checkEqualCol(grid, gridSize, j)) return true;
    }

    return false;
}