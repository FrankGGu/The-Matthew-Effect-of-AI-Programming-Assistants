#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int rows = dungeonSize;
    int cols = dungeonColSize[0];

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    dp[rows - 1][cols - 1] = (dungeon[rows - 1][cols - 1] >= 0) ? 1 : -dungeon[rows - 1][cols - 1] + 1;

    for (int i = rows - 2; i >= 0; i--) {
        dp[i][cols - 1] = (dp[i + 1][cols - 1] - dungeon[i][cols - 1]) > 0 ? dp[i + 1][cols - 1] - dungeon[i][cols - 1] : 1;
    }

    for (int j = cols - 2; j >= 0; j--) {
        dp[rows - 1][j] = (dp[rows - 1][j + 1] - dungeon[rows - 1][j]) > 0 ? dp[rows - 1][j + 1] - dungeon[rows - 1][j] : 1;
    }

    for (int i = rows - 2; i >= 0; i--) {
        for (int j = cols - 2; j >= 0; j--) {
            int minHP = (dp[i + 1][j] < dp[i][j + 1]) ? dp[i + 1][j] : dp[i][j + 1];
            dp[i][j] = (minHP - dungeon[i][j]) > 0 ? minHP - dungeon[i][j] : 1;
        }
    }

    int result = dp[0][0];

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}