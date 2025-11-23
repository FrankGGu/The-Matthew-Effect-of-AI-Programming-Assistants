#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* spiralOrder(int** matrix, int matrixRowSize, int matrixColSize, int* returnSize) {
    if (matrixRowSize == 0 || matrixColSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * matrixRowSize * matrixColSize);
    *returnSize = 0;

    int top = 0, bottom = matrixRowSize - 1;
    int left = 0, right = matrixColSize - 1;
    int dir = 0; // 0: right, 1: down, 2: left, 3: up

    while (top <= bottom && left <= right) {
        if (dir == 0) {
            for (int i = left; i <= right; i++) {
                result[(*returnSize)++] = matrix[top][i];
            }
            top++;
        } else if (dir == 1) {
            for (int i = top; i <= bottom; i++) {
                result[(*returnSize)++] = matrix[i][right];
            }
            right--;
        } else if (dir == 2) {
            for (int i = right; i >= left; i--) {
                result[(*returnSize)++] = matrix[bottom][i];
            }
            bottom--;
        } else if (dir == 3) {
            for (int i = bottom; i >= top; i--) {
                result[(*returnSize)++] = matrix[i][left];
            }
            left++;
        }
        dir = (dir + 1) % 4;
    }

    return result;
}