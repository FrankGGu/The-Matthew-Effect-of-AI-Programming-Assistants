#include <stdio.h>
#include <stdlib.h>

int** imageSmoother(int** img, int imgSize, int* imgColSize, int* returnSize, int** returnColumnSizes) {
    int rows = imgSize;
    int cols = imgColSize[0];
    int** result = (int**)malloc(rows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        (*returnColumnSizes)[i] = cols;
    }
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int sum = 0;
            int count = 0;
            for (int x = -1; x <= 1; x++) {
                for (int y = -1; y <= 1; y++) {
                    int ni = i + x;
                    int nj = j + y;
                    if (ni >= 0 && ni < rows && nj >= 0 && nj < cols) {
                        sum += img[ni][nj];
                        count++;
                    }
                }
            }
            result[i][j] = sum / count;
        }
    }
    *returnSize = rows;
    return result;
}