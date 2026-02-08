#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minFinishTime(int* paint, int paintSize, int** road, int roadSize, int* roadColSize) {
    int n = paintSize;
    int m = roadSize;
    int* dp = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        dp[i] = INT_MAX;
    }
    for (int i = 0; i < m; i++) {
        int cost = road[i][0];
        int color = road[i][1];
        if (color == 0) {
            dp[0] = (dp[0] < cost) ? dp[0] : cost;
        } else {
            for (int j = 0; j < n; j++) {
                if (j != color) {
                    dp[j] = (dp[j] < dp[color] + cost) ? dp[j] : dp[color] + cost;
                }
            }
        }
    }
    int result = INT_MAX;
    for (int i = 0; i < n; i++) {
        result = (result < dp[i]) ? result : dp[i];
    }
    free(dp);
    return result;
}