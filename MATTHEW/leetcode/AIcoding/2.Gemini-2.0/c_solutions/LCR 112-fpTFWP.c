#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int dfs(int** matrix, int i, int j, int rows, int cols, int** dp) {
    if (dp[i][j] != 0) {
        return dp[i][j];
    }

    int max_path = 1;
    int directions[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    for (int k = 0; k < 4; k++) {
        int new_i = i + directions[k][0];
        int new_j = j + directions[k][1];

        if (new_i >= 0 && new_i < rows && new_j >= 0 && new_j < cols && matrix[new_i][new_j] > matrix[i][j]) {
            int path = 1 + dfs(matrix, new_i, new_j, rows, cols, dp);
            if (path > max_path) {
                max_path = path;
            }
        }
    }

    dp[i][j] = max_path;
    return max_path;
}

int longestIncreasingPath(int** matrix, int rows, int* cols) {
    if (rows == 0 || *cols == 0) {
        return 0;
    }

    int cols_val = *cols;
    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)calloc(cols_val, sizeof(int));
    }

    int max_path = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols_val; j++) {
            int path = dfs(matrix, i, j, rows, cols_val, dp);
            if (path > max_path) {
                max_path = path;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return max_path;
}