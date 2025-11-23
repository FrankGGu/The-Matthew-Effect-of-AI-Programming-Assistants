#include <stdio.h>
#include <stdlib.h>

int minCostClimbingStairs(int* cost, int costSize) {
    int* dp = (int*)malloc(costSize * sizeof(int));
    dp[0] = cost[0];
    dp[1] = cost[1];
    for (int i = 2; i < costSize; i++) {
        dp[i] = cost[i] + (dp[i-1] < dp[i-2] ? dp[i-1] : dp[i-2]);
    }
    int result = dp[costSize-1] < dp[costSize-2] ? dp[costSize-1] : dp[costSize-2];
    free(dp);
    return result;
}