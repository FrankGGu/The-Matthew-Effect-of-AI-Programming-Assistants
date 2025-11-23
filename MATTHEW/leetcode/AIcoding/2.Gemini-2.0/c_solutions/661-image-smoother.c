#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** imageSmoother(int** img, int imgSize, int* imgColSize, int* returnSize, int** returnColumnSizes) {
    int rows = imgSize;
    int cols = imgColSize[0];

    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));

    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
    }

    *returnSize = rows;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int sum = 0;
            int count = 0;

            for (int x = i - 1; x <= i + 1; x++) {
                for (int y = j - 1; y <= j + 1; y++) {
                    if (x >= 0 && x < rows && y >= 0 && y < cols) {
                        sum += img[x][y];
                        count++;
                    }
                }
            }

            result[i][j] = sum / count;
        }
    }

    return result;
}