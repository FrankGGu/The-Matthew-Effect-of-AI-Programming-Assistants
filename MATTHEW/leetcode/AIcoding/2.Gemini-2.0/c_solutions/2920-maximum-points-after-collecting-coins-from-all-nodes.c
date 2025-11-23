#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int n, k;
int coins[MAXN];
int dp[MAXN][21][2];
int visited[MAXN];
struct Edge {
    int to;
    struct Edge *next;
};
struct Edge *adj[MAXN];

void addEdge(int u, int v) {
    struct Edge *edge = (struct Edge *)malloc(sizeof(struct Edge));
    edge->to = v;
    edge->next = adj[u];
    adj[u] = edge;
}

void dfs(int u, int parent) {
    visited[u] = 1;
    for (int i = 0; i <= 20; i++) {
        dp[u][i][0] = coins[u] >> i;
        dp[u][i][1] = (coins[u] >> i) - k;
    }

    for (struct Edge *edge = adj[u]; edge != NULL; edge = edge->next) {
        int v = edge->to;
        if (v != parent) {
            dfs(v, u);
            for (int i = 0; i <= 20; i++) {
                int temp0 = dp[u][i][0];
                int temp1 = dp[u][i][1];
                dp[u][i][0] += (dp[v][i][0] > dp[v][i][1] ? dp[v][i][0] : dp[v][i][1]);
                dp[u][i][1] += (dp[v][i + 1][0] > dp[v][i + 1][1] ? dp[v][i + 1][0] : dp[v][i + 1][1]);
            }
        }
    }
}

int maximumPoints(int* _coins, int coinsSize, int** edges, int edgesSize, int* edgesColSize, int _k) {
    n = coinsSize;
    k = _k;
    for (int i = 0; i < n; i++) {
        coins[i] = _coins[i];
        adj[i] = NULL;
        visited[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        addEdge(edges[i][0], edges[i][1]);
        addEdge(edges[i][1], edges[i][0]);
    }

    dfs(0, -1);

    return dp[0][0][0] > dp[0][0][1] ? dp[0][0][0] : dp[0][0][1];
}