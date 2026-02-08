#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int** costs, int costsSize, int* costsColSize){
    if (costsSize == 0) {
        return 0;
    }

    int n = costsSize;
    int dp[n][3];

    dp[0][0] = costs[0][0];
    dp[0][1] = costs[0][1];
    dp[0][2] = costs[0][2];

    for (int i = 1; i < n; i++) {
        dp[i][0] = costs[i][0] + (dp[i-1][1] < dp[i-1][2] ? dp[i-1][1] : dp[i-1][2]);
        dp[i][1] = costs[i][1] + (dp[i-1][0] < dp[i-1][2] ? dp[i-1][0] : dp[i-1][2]);
        dp[i][2] = costs[i][2] + (dp[i-1][0] < dp[i-1][1] ? dp[i-1][0] : dp[i-1][1]);
    }

    int min_cost = dp[n-1][0];
    if (dp[n-1][1] < min_cost) {
        min_cost = dp[n-1][1];
    }
    if (dp[n-1][2] < min_cost) {
        min_cost = dp[n-1][2];
    }

    return min_cost;
}