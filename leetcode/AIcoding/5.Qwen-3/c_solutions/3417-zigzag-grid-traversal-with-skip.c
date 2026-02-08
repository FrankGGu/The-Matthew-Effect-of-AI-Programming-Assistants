#include <stdio.h>
#include <stdlib.h>

int* zigzagGridTraversalWithSkip(int** grid, int gridSize, int* gridColSize, int skip, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int total = rows * cols;
    int* result = (int*)malloc(total * sizeof(int));
    int index = 0;
    int direction = 1; // 1 for right, -1 for left
    int row = 0;
    int col = 0;

    while (index < total) {
        if (skip > 0) {
            skip--;
            if (direction == 1) {
                col++;
                if (col == cols) {
                    row++;
                    direction = -1;
                    col = cols - 1;
                }
            } else {
                col--;
                if (col < 0) {
                    row++;
                    direction = 1;
                    col = 0;
                }
            }
            continue;
        }

        result[index++] = grid[row][col];

        if (direction == 1) {
            col++;
            if (col == cols) {
                row++;
                direction = -1;
                col = cols - 1;
            }
        } else {
            col--;
            if (col < 0) {
                row++;
                direction = 1;
                col = 0;
            }
        }
    }

    *returnSize = index;
    return result;
}