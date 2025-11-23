#include <stdio.h>
#include <stdlib.h>

int maxSideLength(int** grid, int gridSize, int* gridColSize, int threshold) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int** prefix = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        prefix[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int up = (i > 0) ? prefix[i - 1][j] : 0;
            int left = (j > 0) ? prefix[i][j - 1] : 0;
            int diagonal = (i > 0 && j > 0) ? prefix[i - 1][j - 1] : 0;
            prefix[i][j] = grid[i][j] + up + left - diagonal;
        }
    }

    int maxSide = 0;
    int minRow = rows;
    int minCol = cols;

    for (int k = 1; k <= (rows < cols ? rows : cols); k++) {
        for (int i = 0; i <= rows - k; i++) {
            for (int j = 0; j <= cols - k; j++) {
                int x1 = i;
                int y1 = j;
                int x2 = i + k - 1;
                int y2 = j + k - 1;

                int sum = prefix[x2][y2];
                if (x1 > 0) sum -= prefix[x1 - 1][y2];
                if (y1 > 0) sum -= prefix[x2][y1 - 1];
                if (x1 > 0 && y1 > 0) sum += prefix[x1 - 1][y1 - 1];

                if (sum <= threshold) {
                    maxSide = k;
                    break;
                }
            }
            if (maxSide == k) break;
        }
        if (maxSide == k) continue;
    }

    for (int i = 0; i < rows; i++) {
        free(prefix[i]);
    }
    free(prefix);

    return maxSide;
}