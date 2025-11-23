#include <stdio.h>
#include <stdlib.h>

int* spiralOrder(int** matrix, int matrixRowSize, int matrixColSize, int* returnSize) {
    if (matrixRowSize == 0 || matrixColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(matrixRowSize * matrixColSize * sizeof(int));
    int top = 0, bottom = matrixRowSize - 1;
    int left = 0, right = matrixColSize - 1;
    int index = 0;

    while (top <= bottom && left <= right) {
        for (int i = left; i <= right; i++) {
            result[index++] = matrix[top][i];
        }
        top++;

        for (int i = top; i <= bottom; i++) {
            result[index++] = matrix[i][right];
        }
        right--;

        if (top <= bottom) {
            for (int i = right; i >= left; i--) {
                result[index++] = matrix[bottom][i];
            }
            bottom--;
        }

        if (left <= right) {
            for (int i = bottom; i >= top; i--) {
                result[index++] = matrix[i][left];
            }
            left++;
        }
    }

    *returnSize = index;
    return result;
}