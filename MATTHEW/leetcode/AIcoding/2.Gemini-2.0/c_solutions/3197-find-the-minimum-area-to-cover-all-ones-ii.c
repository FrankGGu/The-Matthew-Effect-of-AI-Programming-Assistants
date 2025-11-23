#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minArea(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int top = rows, bottom = -1, left = cols, right = -1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                top = (i < top) ? i : top;
                bottom = (i > bottom) ? i : bottom;
                left = (j < left) ? j : left;
                right = (j > right) ? j : right;
            }
        }
    }

    if (top == rows) return 0;

    int width = right - left + 1;
    int height = bottom - top + 1;

    return width * height;
}