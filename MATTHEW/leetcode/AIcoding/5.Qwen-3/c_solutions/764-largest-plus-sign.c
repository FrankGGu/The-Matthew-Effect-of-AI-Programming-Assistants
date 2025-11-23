#include <stdio.h>
#include <stdlib.h>

int orderOfLargestPlusSign(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = *gridColSize;
    int** left = (int**)malloc(n * sizeof(int*));
    int** right = (int**)malloc(n * sizeof(int*));
    int** up = (int**)malloc(n * sizeof(int*));
    int** down = (int**)malloc(n * sizeof(int*));

    for (int i = 0; i < n; i++) {
        left[i] = (int*)malloc(m * sizeof(int));
        right[i] = (int*)malloc(m * sizeof(int));
        up[i] = (int*)malloc(m * sizeof(int));
        down[i] = (int*)malloc(m * sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                left[i][j] = (j > 0) ? left[i][j - 1] + 1 : 1;
                up[i][j] = (i > 0) ? up[i - 1][j] + 1 : 1;
            } else {
                left[i][j] = 0;
                up[i][j] = 0;
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = m - 1; j >= 0; j--) {
            if (grid[i][j] == 1) {
                right[i][j] = (j < m - 1) ? right[i][j + 1] + 1 : 1;
                down[i][j] = (i < n - 1) ? down[i + 1][j] + 1 : 1;
            } else {
                right[i][j] = 0;
                down[i][j] = 0;
            }
        }
    }

    int maxLen = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int minVal = (left[i][j] < right[i][j]) ? left[i][j] : right[i][j];
            minVal = (minVal < up[i][j]) ? minVal : up[i][j];
            minVal = (minVal < down[i][j]) ? minVal : down[i][j];
            if (minVal > maxLen) {
                maxLen = minVal;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(left[i]);
        free(right[i]);
        free(up[i]);
        free(down[i]);
    }
    free(left);
    free(right);
    free(up);
    free(down);

    return maxLen;
}