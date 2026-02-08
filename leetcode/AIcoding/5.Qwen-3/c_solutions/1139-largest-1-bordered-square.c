#include <stdio.h>
#include <stdlib.h>

int largestSquare(int** grid, int gridSize, int* gridColSize) {
    int maxLen = 0;
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int len = 1;
                while (i + len < rows && j + len < cols && grid[i + len][j] == 1 && grid[i][j + len] == 1) {
                    len++;
                }
                if (len > maxLen) {
                    maxLen = len;
                }
            }
        }
    }

    return maxLen * maxLen;
}