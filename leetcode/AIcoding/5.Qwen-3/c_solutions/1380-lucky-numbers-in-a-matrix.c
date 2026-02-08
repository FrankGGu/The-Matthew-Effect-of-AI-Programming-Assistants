#include <stdio.h>
#include <stdlib.h>

int* luckyNumbers(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];
    int* minRow = (int*)malloc(rows * sizeof(int));
    int* maxCol = (int*)malloc(cols * sizeof(int));

    for (int i = 0; i < rows; i++) {
        int minVal = matrix[i][0];
        for (int j = 1; j < cols; j++) {
            if (matrix[i][j] < minVal) {
                minVal = matrix[i][j];
            }
        }
        minRow[i] = minVal;
    }

    for (int j = 0; j < cols; j++) {
        int maxVal = matrix[0][j];
        for (int i = 1; i < rows; i++) {
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }
        maxCol[j] = maxVal;
    }

    int* result = (int*)malloc(sizeof(int) * rows);
    int count = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == minRow[i] && matrix[i][j] == maxCol[j]) {
                result[count++] = matrix[i][j];
                break;
            }
        }
    }

    *returnSize = count;
    return result;
}