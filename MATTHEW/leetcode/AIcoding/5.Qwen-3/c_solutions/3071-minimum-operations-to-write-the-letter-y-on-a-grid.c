#include <stdio.h>
#include <stdlib.h>

int minimumOperationsToWriteY(char** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int yCenter = rows / 2;
    int operations = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i <= yCenter) {
                if (j == i || j == cols - 1 - i || i == yCenter) {
                    if (grid[i][j] != 'Y') {
                        operations++;
                    }
                } else {
                    if (grid[i][j] != 'O') {
                        operations++;
                    }
                }
            } else {
                if (j == i - yCenter || j == cols - 1 - (i - yCenter)) {
                    if (grid[i][j] != 'Y') {
                        operations++;
                    }
                } else {
                    if (grid[i][j] != 'O') {
                        operations++;
                    }
                }
            }
        }
    }

    return operations;
}