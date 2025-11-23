#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 101
#define INF INT_MAX

int minCost(int maxTime, int** edges, int edgesSize, int* edgesColSize, int* passingFees, int passingFeesSize) {
    int n = passingFeesSize;
    int dp[n][maxTime + 1];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= maxTime; j++) {
            dp[i][j] = INF;
        }
    }

    dp[0][0] = passingFees[0];

    for (int t = 1; t <= maxTime; t++) {
        for (int i = 0; i < edgesSize; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int time = edges[i][2];

            if (time <= t) {
                if (dp[u][t - time] != INF) {
                    dp[v][t] = (dp[v][t] == INF) ? (dp[u][t - time] + passingFees[v]) : (dp[v][t] < (dp[u][t - time] + passingFees[v]) ? dp[v][t] : (dp[u][t - time] + passingFees[v]));
                }
                if (dp[v][t - time] != INF) {
                    dp[u][t] = (dp[u][t] == INF) ? (dp[v][t - time] + passingFees[u]) : (dp[u][t] < (dp[v][t - time] + passingFees[u]) ? dp[u][t] : (dp[v][t - time] + passingFees[u]));
                }
            }
        }
    }

    int min_cost = INF;
    for (int t = 0; t <= maxTime; t++) {
        if (dp[n - 1][t] != INF) {
            min_cost = (min_cost < dp[n - 1][t]) ? min_cost : dp[n - 1][t];
        }
    }

    return (min_cost == INF) ? -1 : min_cost;
}