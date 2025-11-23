#include <stdio.h>
#include <stdlib.h>

int* rowWithMax1s(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int maxRow = 0;
    int maxCount = 0;
    int colSize = matrixColSize[0];

    for (int i = 0; i < matrixSize; i++) {
        int count = 0;
        for (int j = 0; j < colSize; j++) {
            if (matrix[i][j] == 1) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
            maxRow = i;
        }
    }

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = maxRow;
    result[1] = maxCount;
    *returnSize = 2;
    return result;
}