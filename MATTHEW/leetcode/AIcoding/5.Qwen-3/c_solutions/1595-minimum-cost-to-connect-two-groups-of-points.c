#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int minCostToConnectTwoGroups(int** cost, int costSize, int* costColSize) {
    int m = costSize;
    int n = costColSize[0];
    int dp[1 << 10];
    int new_dp[1 << 10];
    for (int i = 0; i < (1 << 10); i++) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < (1 << 10); j++) {
            new_dp[j] = dp[j];
        }
        for (int j = 0; j < (1 << 10); j++) {
            if (dp[j] == INT_MAX) continue;
            for (int k = 0; k < n; k++) {
                int next_mask = j | (1 << k);
                if (new_dp[next_mask] > dp[j] + cost[i][k]) {
                    new_dp[next_mask] = dp[j] + cost[i][k];
                }
            }
        }
        for (int j = 0; j < (1 << 10); j++) {
            dp[j] = new_dp[j];
        }
    }

    int result = INT_MAX;
    for (int i = 0; i < (1 << 10); i++) {
        if (dp[i] < result) {
            result = dp[i];
        }
    }
    return result;
}