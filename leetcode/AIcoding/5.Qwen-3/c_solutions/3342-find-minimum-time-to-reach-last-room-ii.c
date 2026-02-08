#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Position;

int compare(const void *a, const void::b) {
    return (*(int*)a - *(int*)b);
}

int dfs(int** dungeon, int rows, int cols, int row, int col, int** dp) {
    if (row == rows || col == cols) return INT_MIN;
    if (row == rows - 1 && col == cols - 1) return dungeon[row][col] > 0 ? 0 : -dungeon[row][col];

    if (dp[row][col] != -1) return dp[row][col];

    int right = dfs(dungeon, rows, cols, row, col + 1, dp);
    int down = dfs(dungeon, rows, cols, row + 1, col, dp);

    int minHealth = fmin(right, down);
    if (minHealth == INT_MIN) {
        minHealth = 0;
    }

    int res = (dungeon[row][col] > 0) ? (minHealth - dungeon[row][col]) : (minHealth - dungeon[row][col]);
    if (res < 0) res = 0;

    dp[row][col] = res;
    return res;
}

int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int rows = dungeonSize;
    int cols = *dungeonColSize;

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dp[i][j] = -1;
        }
    }

    int result = dfs(dungeon, rows, cols, 0, 0, dp);

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result + 1;
}