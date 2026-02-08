#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* spiralOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize){
    if (matrixSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matrixSize;
    int cols = matrixColSize[0];
    int* result = (int*)malloc(sizeof(int) * rows * cols);
    *returnSize = rows * cols;

    int top = 0, bottom = rows - 1, left = 0, right = cols - 1;
    int index = 0;

    while (top <= bottom && left <= right) {
        // Traverse right
        for (int i = left; i <= right; i++) {
            result[index++] = matrix[top][i];
        }
        top++;

        // Traverse down
        for (int i = top; i <= bottom; i++) {
            result[index++] = matrix[i][right];
        }
        right--;

        if (top <= bottom && left <= right) {
            // Traverse left
            for (int i = right; i >= left; i--) {
                result[index++] = matrix[bottom][i];
            }
            bottom--;

            // Traverse up
            for (int i = bottom; i >= top; i--) {
                result[index++] = matrix[i][left];
            }
            left++;
        }
    }

    return result;
}