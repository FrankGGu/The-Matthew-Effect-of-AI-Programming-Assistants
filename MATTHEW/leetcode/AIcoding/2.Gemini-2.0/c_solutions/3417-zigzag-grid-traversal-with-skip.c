#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* zigzagTraverseWithSkip(int** grid, int gridSize, int* gridColSize, int skip, int* returnSize) {
    if (gridSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = gridSize;
    int cols = gridColSize[0];
    int* result = (int*)malloc(sizeof(int) * rows * cols);
    *returnSize = 0;

    int row = 0, col = 0, direction = 1; // 1 for up, -1 for down
    int skipped = 0;

    while (*returnSize < rows * cols) {
        if (skipped < skip) {
            skipped++;
        } else {
            result[*returnSize] = grid[row][col];
            (*returnSize)++;
            skipped = 0;
        }

        if (direction == 1) { // Moving up
            if (row - 1 >= 0 && col + 1 < cols) {
                row--;
                col++;
            } else {
                if (col + 1 < cols) {
                    col++;
                    direction = -1;
                } else {
                    row++;
                    direction = -1;
                }
            }
        } else { // Moving down
            if (row + 1 < rows && col - 1 >= 0) {
                row++;
                col--;
            } else {
                if (row + 1 < rows) {
                    row++;
                    direction = 1;
                } else {
                    col++;
                    direction = 1;
                }
            }
        }
    }

    return result;
}