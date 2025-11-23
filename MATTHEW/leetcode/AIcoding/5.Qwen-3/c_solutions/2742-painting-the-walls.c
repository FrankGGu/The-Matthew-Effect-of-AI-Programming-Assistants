#include <stdio.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int minCostToPaintWalls(int* cost, int costSize, int* time, int timeSize) {
    int dp[10001];
    for (int i = 0; i <= 10000; i++) {
        dp[i] = 1e9;
    }
    dp[0] = 0;
    for (int i = 0; i < costSize; i++) {
        for (int j = 10000; j >= 0; j--) {
            if (dp[j] != 1e9) {
                dp[min(j + time[i], 10000)] = min(dp[min(j + time[i], 10000)], dp[j] + cost[i]);
            }
        }
    }
    return dp[10000];
}