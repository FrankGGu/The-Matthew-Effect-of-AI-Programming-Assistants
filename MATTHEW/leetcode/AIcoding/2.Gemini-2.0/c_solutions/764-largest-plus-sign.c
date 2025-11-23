#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int orderOfLargestPlusSign(int n, int** mines, int minesSize, int* minesColSize) {
    int grid[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            grid[i][j] = 1;
        }
    }

    for (int i = 0; i < minesSize; i++) {
        grid[mines[i][0]][mines[i][1]] = 0;
    }

    int up[n][n], down[n][n], left[n][n], right[n][n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            up[i][j] = down[i][j] = left[i][j] = right[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                up[i][j] = (i > 0 ? up[i - 1][j] + 1 : 1);
                left[i][j] = (j > 0 ? left[i][j - 1] + 1 : 1);
            }
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            if (grid[i][j] == 1) {
                down[i][j] = (i < n - 1 ? down[i + 1][j] + 1 : 1);
                right[i][j] = (j < n - 1 ? right[i][j + 1] + 1 : 1);
            }
        }
    }

    int maxOrder = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int order = (up[i][j] < down[i][j] ? up[i][j] : down[i][j]);
            order = (order < left[i][j] ? order : left[i][j]);
            order = (order < right[i][j] ? order : right[i][j]);
            if (order > maxOrder) {
                maxOrder = order;
            }
        }
    }

    return maxOrder;
}