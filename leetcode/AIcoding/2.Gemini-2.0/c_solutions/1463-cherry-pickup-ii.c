#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cherryPickup(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];

    int*** dp = (int***)malloc(sizeof(int**) * rows);
    for (int i = 0; i < rows; i++) {
        dp[i] = (int**)malloc(sizeof(int*) * cols);
        for (int j = 0; j < cols; j++) {
            dp[i][j] = (int*)malloc(sizeof(int) * cols);
            for (int k = 0; k < cols; k++) {
                dp[i][j][k] = -1;
            }
        }
    }

    int solve(int row, int col1, int col2) {
        if (row == rows) {
            return 0;
        }

        if (col1 < 0 || col1 >= cols || col2 < 0 || col2 >= cols) {
            return INT_MIN;
        }

        if (dp[row][col1][col2] != -1) {
            return dp[row][col1][col2];
        }

        int cherries = grid[row][col1];
        if (col1 != col2) {
            cherries += grid[row][col2];
        }

        int maxCherries = INT_MIN;
        for (int i = -1; i <= 1; i++) {
            for (int j = -1; j <= 1; j++) {
                int nextCol1 = col1 + i;
                int nextCol2 = col2 + j;
                maxCherries = (maxCherries > solve(row + 1, nextCol1, nextCol2)) ? maxCherries : solve(row + 1, nextCol1, nextCol2);
            }
        }

        dp[row][col1][col2] = cherries + maxCherries;
        return dp[row][col1][col2];
    }

    int result = solve(0, 0, cols - 1);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return result;
}