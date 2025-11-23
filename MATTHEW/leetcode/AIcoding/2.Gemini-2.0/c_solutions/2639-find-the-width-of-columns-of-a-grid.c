#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findColumnWidth(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    *returnSize = gridColSize[0];
    int* result = (int*)malloc(sizeof(int) * (*returnSize));

    for (int j = 0; j < *returnSize; j++) {
        int max_width = 0;
        for (int i = 0; i < gridSize; i++) {
            int num = grid[i][j];
            int width = 0;
            if (num == 0) {
                width = 1;
            } else {
                if (num < 0) {
                    width++;
                    num = -num;
                }
                while (num > 0) {
                    num /= 10;
                    width++;
                }
            }
            if (width > max_width) {
                max_width = width;
            }
        }
        result[j] = max_width;
    }

    return result;
}