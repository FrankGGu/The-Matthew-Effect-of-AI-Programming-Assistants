#include <stdlib.h> // For malloc, realloc
#include <stdbool.h> // For bool type

int* luckyNumbers (int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int rows = matrixSize;
    int cols = matrixColSize[0];

    int* luckyNumbersArray = (int*)malloc(sizeof(int) * rows);
    *returnSize = 0;

    for (int i = 0; i < rows; i++) {
        int minValInRow = matrix[i][0];
        int minColIdx = 0;
        for (int j = 1; j < cols; j++) {
            if (matrix[i][j] < minValInRow) {
                minValInRow = matrix[i][j];
                minColIdx = j;
            }
        }

        bool isMaxInCol = true;
        for (int k = 0; k < rows; k++) {
            if (matrix[k][minColIdx] > minValInRow) {
                isMaxInCol = false;
                break;
            }
        }

        if (isMaxInCol) {
            luckyNumbersArray[*returnSize] = minValInRow;
            (*returnSize)++;
        }
    }

    luckyNumbersArray = (int*)realloc(luckyNumbersArray, sizeof(int) * (*returnSize));

    return luckyNumbersArray;
}