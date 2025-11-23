#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countUnguarded(int m, int n, int** guards, int guardsSize, int* guardsColSize, int** walls, int wallsSize, int* wallsColSize) {
    int** grid = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        grid[i] = (int*)calloc(n, sizeof(int));
    }

    for (int i = 0; i < wallsSize; i++) {
        grid[walls[i][0]][walls[i][1]] = 2;
    }

    for (int i = 0; i < guardsSize; i++) {
        grid[guards[i][0]][guards[i][1]] = 1;
    }

    for (int i = 0; i < guardsSize; i++) {
        int row = guards[i][0];
        int col = guards[i][1];

        // Left
        for (int j = col - 1; j >= 0; j--) {
            if (grid[row][j] == 2 || grid[row][j] == 1) {
                break;
            }
            grid[row][j] = 3;
        }

        // Right
        for (int j = col + 1; j < n; j++) {
            if (grid[row][j] == 2 || grid[row][j] == 1) {
                break;
            }
            grid[row][j] = 3;
        }

        // Up
        for (int k = row - 1; k >= 0; k--) {
            if (grid[k][col] == 2 || grid[k][col] == 1) {
                break;
            }
            grid[k][col] = 3;
        }

        // Down
        for (int k = row + 1; k < m; k++) {
            if (grid[k][col] == 2 || grid[k][col] == 1) {
                break;
            }
            grid[k][col] = 3;
        }
    }

    int unguarded = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                unguarded++;
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(grid[i]);
    }
    free(grid);

    return unguarded;
}