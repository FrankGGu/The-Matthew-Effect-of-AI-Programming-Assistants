#include <stdio.h>
#include <stdlib.h>

int maxPoints(int** enemyBattles, int enemyBattlesSize, int* enemyBattlesColSize) {
    int n = enemyBattlesSize;
    int m = enemyBattlesColSize[0];
    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = 0;
    }

    for (int i = 0; i < n; i++) {
        int maxVal = 0;
        for (int j = 0; j < i; j++) {
            if (enemyBattles[j][0] < enemyBattles[i][0] && enemyBattles[j][1] < enemyBattles[i][1]) {
                maxVal = (maxVal > dp[j]) ? maxVal : dp[j];
            }
        }
        dp[i] = maxVal + enemyBattles[i][2];
    }

    int result = 0;
    for (int i = 0; i < n; i++) {
        result = (result > dp[i]) ? result : dp[i];
    }

    free(dp);
    return result;
}