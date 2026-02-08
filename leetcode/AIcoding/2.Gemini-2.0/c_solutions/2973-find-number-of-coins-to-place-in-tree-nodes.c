#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 30005

int n;
int coins[MAXN];
int degree[MAXN];
int adj[MAXN][3];
long long dp[MAXN][2];
long long ans[MAXN];

void dfs(int u, int p) {
    dp[u][1] = coins[u];
    dp[u][0] = 0;

    for (int i = 0; i < degree[u]; i++) {
        int v = adj[u][i];
        if (v == p) continue;
        dfs(v, u);
        long long new_dp0 = dp[u][0] + (dp[v][0] > dp[v][1] ? dp[v][0] : dp[v][1]);
        long long new_dp1 = dp[u][1] + dp[v][0];
        dp[u][0] = new_dp0;
        dp[u][1] = new_dp1;
    }
}

void dfs2(int u, int p, long long up0, long long up1) {
    long long temp0 = dp[u][0];
    long long temp1 = dp[u][1];
    dp[u][0] = up0;
    dp[u][1] = up1 + coins[u];
    ans[u] = (dp[u][0] > dp[u][1] ? dp[u][0] : dp[u][1]);

    for (int i = 0; i < degree[u]; i++) {
        int v = adj[u][i];
        if (v == p) continue;
        long long sum0 = 0, sum1 = coins[u];
        for (int j = 0; j < degree[u]; j++) {
            int w = adj[u][j];
            if (w == v) continue;
            if (w == p) {
                sum0 += up0 > up1 ? up0 : up1;
                sum1 += up0;
                continue;
            }

            sum0 += dp[w][0] > dp[w][1] ? dp[w][0] : dp[w][1];
            sum1 += dp[w][0];
        }

        dfs2(v, u, sum0, sum1);
    }

    dp[u][0] = temp0;
    dp[u][1] = temp1;
}

long long* placedCoins(int* edges, int edgesSize, int* cost, int costSize) {
    n = costSize;
    for (int i = 0; i < n; i++) {
        coins[i] = cost[i];
        degree[i] = 0;
    }

    for (int i = 0; i < edgesSize / 2; i++) {
        int u = edges[2 * i];
        int v = edges[2 * i + 1];
        adj[u][degree[u]++] = v;
        adj[v][degree[v]++] = u;
    }

    dfs(0, -1);
    dfs2(0, -1, 0, 0);

    long long* result = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        result[i] = ans[i];
    }

    return result;
}