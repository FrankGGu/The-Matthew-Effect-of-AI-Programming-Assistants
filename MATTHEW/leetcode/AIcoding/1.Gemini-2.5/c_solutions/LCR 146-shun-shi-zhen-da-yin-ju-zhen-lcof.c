#include <stdlib.h>

int* spiralOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    if (matrixSize == 0 || matrixColSize == NULL || matrixColSize[0] == 0) {
        *returnSize = 0;
        return NULL;
    }

    int m = matrixSize;
    int n = matrixColSize[0];
    *returnSize = m * n;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int top = 0;
    int bottom = m - 1;
    int left = 0;
    int right = n - 1;
    int index = 0;

    while (top <= bottom && left <= right) {
        // Traverse right
        for (int col = left; col <= right; col++) {
            result[index++] = matrix[top][col];
        }
        top++;

        // Traverse down
        for (int row = top; row <= bottom; row++) {
            result[index++] = matrix[row][right];
        }
        right--;

        // Traverse left (if there's still a row)
        if (top <= bottom) {
            for (int col = right; col >= left; col--) {
                result[index++] = matrix[bottom][col];
            }
            bottom--;
        }

        // Traverse up (if there's still a column)
        if (left <= right) {
            for (int row = bottom; row >= top; row--) {
                result[index++] = matrix[row][left];
            }
            left++;
        }
    }

    return result;
}