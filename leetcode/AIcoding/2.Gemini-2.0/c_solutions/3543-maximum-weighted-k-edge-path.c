#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 105
#define INF INT_MIN

int dp[MAXN][MAXN][MAXN];

int max(int a, int b) {
    return (a > b) ? a : b;
}

int solve(int n, int k, int u, int adj[MAXN][MAXN]) {
    if (k == 0) {
        return (u == 0) ? 0 : INF;
    }

    if (dp[u][k][0] != -1) {
        return dp[u][k][0];
    }

    int ans = INF;
    for (int v = 0; v < n; v++) {
        if (adj[u][v] != INF) {
            int temp = solve(n, k - 1, v, adj);
            if (temp != INF) {
                ans = max(ans, temp + adj[u][v]);
            }
        }
    }

    return dp[u][k][0] = ans;
}

int maxWeightedKEdgePath(int n, int k, int edges[][3], int edgesSize, int edgesColSize) {
    int adj[MAXN][MAXN];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            adj[i][j] = INF;
        }
    }

    for (int i = 0; i < edgesSize; i++) {
        adj[edges[i][0]][edges[i][1]] = edges[i][2];
    }

    for (int i = 0; i < MAXN; i++) {
        for (int j = 0; j < MAXN; j++) {
            for (int l = 0; l < MAXN; l++) {
                dp[i][j][l] = -1;
            }
        }
    }

    int result = solve(n, k, 0, adj);

    return (result == INF) ? -1 : result;
}