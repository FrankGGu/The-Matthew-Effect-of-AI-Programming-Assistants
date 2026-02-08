#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** generateMatrix(int n, int* returnSize, int** returnColumnSizes) {
    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** matrix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
    }

    int num = 1;
    int top = 0, bottom = n - 1, left = 0, right = n - 1;

    while (num <= n * n) {
        for (int i = left; i <= right && num <= n * n; i++) {
            matrix[top][i] = num++;
        }
        top++;

        for (int i = top; i <= bottom && num <= n * n; i++) {
            matrix[i][right] = num++;
        }
        right--;

        for (int i = right; i >= left && num <= n * n; i--) {
            matrix[bottom][i] = num++;
        }
        bottom--;

        for (int i = bottom; i >= top && num <= n * n; i--) {
            matrix[i][left] = num++;
        }
        left++;
    }

    return matrix;
}