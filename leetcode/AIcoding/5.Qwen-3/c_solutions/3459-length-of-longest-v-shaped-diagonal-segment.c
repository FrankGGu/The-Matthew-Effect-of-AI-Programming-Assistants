#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int longestVShape(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int maxLen = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int len = 1;
            int x = i - 1, y = j + 1;
            while (x >= 0 && y < cols) {
                len++;
                x--;
                y++;
            }
            x = i + 1;
            y = j - 1;
            while (x < rows && y >= 0) {
                len++;
                x++;
                y--;
            }
            if (len > maxLen) {
                maxLen = len;
            }
        }
    }

    return maxLen;
}