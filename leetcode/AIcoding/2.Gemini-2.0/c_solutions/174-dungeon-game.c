#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int calculateMinimumHP(int** dungeon, int dungeonSize, int* dungeonColSize) {
    int rows = dungeonSize;
    int cols = *dungeonColSize;

    int** dp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dp[i] = (int*)malloc(cols * sizeof(int));
    }

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            if (i == rows - 1 && j == cols - 1) {
                dp[i][j] = (dungeon[i][j] >= 0) ? 1 : 1 - dungeon[i][j];
            } else if (i == rows - 1) {
                dp[i][j] = (dungeon[i][j] >= dp[i][j + 1]) ? 1 : dp[i][j + 1] - dungeon[i][j];
            } else if (j == cols - 1) {
                dp[i][j] = (dungeon[i][j] >= dp[i + 1][j]) ? 1 : dp[i + 1][j] - dungeon[i][j];
            } else {
                int min_hp = (dp[i + 1][j] < dp[i][j + 1]) ? dp[i + 1][j] : dp[i][j + 1];
                dp[i][j] = (dungeon[i][j] >= min_hp) ? 1 : min_hp - dungeon[i][j];
            }
        }
    }

    int result = dp[0][0];

    for (int i = 0; i < rows; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}