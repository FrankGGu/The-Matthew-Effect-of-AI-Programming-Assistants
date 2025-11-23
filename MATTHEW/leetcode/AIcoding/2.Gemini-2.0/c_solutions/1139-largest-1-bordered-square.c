#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largest1BorderedSquare(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int** horizontal = (int**)malloc(n * sizeof(int*));
    int** vertical = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        horizontal[i] = (int*)malloc(m * sizeof(int));
        vertical[i] = (int*)malloc(m * sizeof(int));
        for (int j = 0; j < m; j++) {
            horizontal[i][j] = 0;
            vertical[i][j] = 0;
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 1) {
                horizontal[i][j] = (j == 0) ? 1 : horizontal[i][j - 1] + 1;
                vertical[i][j] = (i == 0) ? 1 : vertical[i - 1][j] + 1;
            }
        }
    }

    int max_side = 0;
    for (int i = n - 1; i >= 0; i--) {
        for (int j = m - 1; j >= 0; j--) {
            int side = fmin(horizontal[i][j], vertical[i][j]);
            while (side > max_side) {
                if (vertical[i][j - side + 1] >= side && horizontal[i - side + 1][j] >= side) {
                    max_side = side;
                    break;
                }
                side--;
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(horizontal[i]);
        free(vertical[i]);
    }
    free(horizontal);
    free(vertical);

    return max_side * max_side;
}