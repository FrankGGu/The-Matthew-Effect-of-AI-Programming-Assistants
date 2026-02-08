#include <stdlib.h>

int** fillGrid(int n, int* returnSize, int** returnColumnSizes) {
    if (n <= 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int** grid = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int i = 0; i < n; i++) {
        grid[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    int top = 0;
    int bottom = n - 1;
    int left = 0;
    int right = n - 1;
    int num = 1;

    while (top <= bottom && left <= right) {
        // Fill top row from left to right
        for (int col = left; col <= right; col++) {
            grid[top][col] = num++;
        }
        top++;

        // Fill right column from top to bottom
        for (int row = top; row <= bottom; row++) {
            grid[row][right] = num++;
        }
        right--;

        // Fill bottom row from right to left
        if (top <= bottom) {
            for (int col = right; col >= left; col--) {
                grid[bottom][col] = num++;
            }
            bottom--;
        }

        // Fill left column from bottom to top
        if (left <= right) {
            for (int row = bottom; row >= top; row--) {
                grid[row][left] = num++;
            }
            left++;
        }
    }

    return grid;
}