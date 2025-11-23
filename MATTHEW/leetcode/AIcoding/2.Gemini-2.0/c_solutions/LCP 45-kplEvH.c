#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define INF 0x3f3f3f3f

int minCost(int** roads, int roadsSize, int* roadsColSize, int start, int target, int k) {
    int n = 0;
    for (int i = 0; i < roadsSize; i++) {
        n = (n > roads[i][0] ? n : roads[i][0]);
        n = (n > roads[i][1] ? n : roads[i][1]);
    }
    n++;

    int dist[n][n];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            dist[i][j] = INF;
        }
    }
    for (int i = 0; i < n; i++) {
        dist[i][i] = 0;
    }

    for (int i = 0; i < roadsSize; i++) {
        dist[roads[i][0]][roads[i][1]] = roads[i][2];
    }

    int dp[k + 2][n];
    for (int i = 0; i <= k + 1; i++) {
        for (int j = 0; j < n; j++) {
            dp[i][j] = INF;
        }
    }

    dp[0][start] = 0;

    for (int i = 1; i <= k + 1; i++) {
        for (int j = 0; j < n; j++) {
            for (int l = 0; l < n; l++) {
                if (dist[l][j] != INF && dp[i - 1][l] != INF) {
                    dp[i][j] = (dp[i][j] < dp[i - 1][l] + dist[l][j] ? dp[i][j] : dp[i - 1][l] + dist[l][j]);
                }
            }
        }
    }

    int ans = INF;
    for (int i = 0; i <= k + 1; i++) {
        ans = (ans < dp[i][target] ? ans : dp[i][target]);
    }

    return (ans == INF ? -1 : ans);
}