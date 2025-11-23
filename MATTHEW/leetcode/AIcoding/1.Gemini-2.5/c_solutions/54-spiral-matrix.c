#include <stdlib.h>

int* spiralOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;
    int* result = (int*)malloc(rows * cols * sizeof(int));
    *returnSize = rows * cols;

    int top = 0;
    int bottom = rows - 1;
    int left = 0;
    int right = cols - 1;
    int index = 0;

    while (top <= bottom && left <= right) {
        // Traverse right
        for (int c = left; c <= right; c++) {
            result[index++] = matrix[top][c];
        }
        top++;

        // Traverse down
        for (int r = top; r <= bottom; r++) {
            result[index++] = matrix[r][right];
        }
        right--;

        // Traverse left
        if (top <= bottom) {
            for (int c = right; c >= left; c--) {
                result[index++] = matrix[bottom][c];
            }
            bottom--;
        }

        // Traverse up
        if (left <= right) {
            for (int r = bottom; r >= top; r--) {
                result[index++] = matrix[r][left];
            }
            left++;
        }
    }

    return result;
}