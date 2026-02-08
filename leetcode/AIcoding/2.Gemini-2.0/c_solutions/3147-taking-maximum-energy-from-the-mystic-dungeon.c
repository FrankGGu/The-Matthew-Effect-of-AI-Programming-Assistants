#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int min(int a, int b) {
    return (a < b) ? a : b;
}

int maximumEnergy(int dungeon[][100], int dungeonSize, int dungeonColSize[]) {
    int dp[dungeonSize][dungeonColSize[0]];

    for (int i = dungeonSize - 1; i >= 0; i--) {
        for (int j = dungeonColSize[0] - 1; j >= 0; j--) {
            if (i == dungeonSize - 1 && j == dungeonColSize[0] - 1) {
                dp[i][j] = max(1, 1 - dungeon[i][j]);
            } else if (i == dungeonSize - 1) {
                dp[i][j] = max(1, dp[i][j + 1] - dungeon[i][j]);
            } else if (j == dungeonColSize[0] - 1) {
                dp[i][j] = max(1, dp[i + 1][j] - dungeon[i][j]);
            } else {
                dp[i][j] = max(1, min(dp[i + 1][j], dp[i][j + 1]) - dungeon[i][j]);
            }
        }
    }

    return dp[0][0];
}