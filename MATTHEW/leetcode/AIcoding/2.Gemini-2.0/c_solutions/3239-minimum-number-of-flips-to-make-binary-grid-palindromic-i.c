#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minFlips(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;
    int m = gridColSize[0];
    int min_flips = INT_MAX;

    for (int mask = 0; mask < (1 << n); mask++) {
        int flips = 0;
        int** temp_grid = (int**)malloc(n * sizeof(int*));
        for (int i = 0; i < n; i++) {
            temp_grid[i] = (int*)malloc(m * sizeof(int));
            for (int j = 0; j < m; j++) {
                temp_grid[i][j] = grid[i][j];
            }
        }

        for (int i = 0; i < n; i++) {
            if ((mask >> i) & 1) {
                flips++;
                for (int j = 0; j < m; j++) {
                    temp_grid[i][j] = 1 - temp_grid[i][j];
                }
            }
        }

        int is_palindrome = 1;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m / 2; j++) {
                if (temp_grid[i][j] != temp_grid[i][m - 1 - j]) {
                    is_palindrome = 0;
                    break;
                }
            }
            if (!is_palindrome) break;
        }

        if (is_palindrome) {
            if (flips < min_flips) {
                min_flips = flips;
            }
        }

        for (int i = 0; i < n; i++) {
            free(temp_grid[i]);
        }
        free(temp_grid);
    }

    return (min_flips == INT_MAX) ? -1 : min_flips;
}