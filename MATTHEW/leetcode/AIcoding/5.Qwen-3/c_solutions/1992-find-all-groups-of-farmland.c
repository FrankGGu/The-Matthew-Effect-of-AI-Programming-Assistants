#include <stdio.h>
#include <stdlib.h>

int** findFarmland(int** land, int landRowSize, int landColSize, int** returnSize, int** returnColumnSizes) {
    int rows = landRowSize;
    int cols = landColSize;
    int** result = (int**)malloc(rows * cols * sizeof(int*));
    *returnSize = 0;
    *returnColumnSizes = (int*)malloc(rows * cols * sizeof(int));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (land[i][j] == 1) {
                int x = i;
                int y = j;
                while (x < rows && land[x][j] == 1) x++;
                while (y < cols && land[i][y] == 1) y++;
                result[*returnSize] = (int*)malloc(4 * sizeof(int));
                result[*returnSize][0] = i;
                result[*returnSize][1] = j;
                result[*returnSize][2] = x - 1;
                result[*returnSize][3] = y - 1;
                (*returnSize)++;
                *returnColumnSizes[*returnSize - 1] = 4;
                for (int a = i; a < x; a++) {
                    for (int b = j; b < y; b++) {
                        land[a][b] = 0;
                    }
                }
            }
        }
    }

    return result;
}