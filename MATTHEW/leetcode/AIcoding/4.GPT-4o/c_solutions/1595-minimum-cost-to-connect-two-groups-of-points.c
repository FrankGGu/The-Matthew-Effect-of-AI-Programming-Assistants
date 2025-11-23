#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#define MAX 16

int minCost(int** cost, int n, int m) {
    int dp[1 << MAX];
    for (int i = 0; i < (1 << MAX); i++) dp[i] = INT_MAX;
    dp[0] = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < m; i++) {
            int newMask = mask;
            for (int j = 0; j < n; j++) {
                if (!(mask & (1 << j))) {
                    newMask |= (1 << j);
                    dp[newMask] = fmin(dp[newMask], dp[mask] + cost[j][i]);
                }
            }
        }
    }
    return dp[(1 << n) - 1];
}

int minCostConnectPoints(int** points, int pointsSize, int* pointsColSize) {
    int cost[MAX][MAX] = {0};
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < *pointsColSize; j++) {
            cost[i][j] = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1]);
        }
    }
    return minCost(cost, pointsSize, pointsSize);
}