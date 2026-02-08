#include <stdlib.h>
#include <string.h>

#define MAX_N 30000

int head[MAX_N], next[MAX_N * 2], to[MAX_N * 2], cnt;
int coins[MAX_N];
long long dp[MAX_N][2];

void addEdge(int u, int v) {
    next[cnt] = head[u];
    to[cnt] = v;
    head[u] = cnt++;
}

void dfs(int u, int parent, int k) {
    long long sum0 = 0, sum1 = 0;
    int children = 0;

    for (int i = head[u]; i != -1; i = next[i]) {
        int v = to[i];
        if (v == parent) continue;
        children++;
        dfs(v, u, k);
        sum0 += dp[v][0];
        sum1 += dp[v][1];
    }

    if (children == 0) {
        dp[u][0] = coins[u];
        dp[u][1] = coins[u] - k;
    } else {
        dp[u][0] = coins[u] + sum0;
        long long option1 = coins[u] - k + sum1;
        long long option2 = coins[u] + sum0 - k * children;
        dp[u][1] = (option1 > option2) ? option1 : option2;
    }
}

long long maximumPoints(int** edges, int edgesSize, int* edgesColSize, int* coins, int coinsSize, int k) {
    cnt = 0;
    memset(head, -1, sizeof(head));

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1]);
        addEdge(edges[i][1], edges[i][0]);
    }

    memcpy(::coins, coins, coinsSize * sizeof(int));

    dfs(0, -1, k);

    return (dp[0][0] > dp[0][1]) ? dp[0][0] : dp[0][1];
}