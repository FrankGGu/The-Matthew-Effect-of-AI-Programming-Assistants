#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005
#define MAXM 200005

int n, m;
int head[MAXN], to[MAXM], next[MAXM], edge_cnt;
int a[MAXN];
int dp[MAXN][2];

void add_edge(int u, int v) {
    to[edge_cnt] = v;
    next[edge_cnt] = head[u];
    head[u] = edge_cnt++;
}

int max(int a, int b) {
    return a > b ? a : b;
}

void dfs(int u, int p) {
    dp[u][a[u]] = 1;
    dp[u][1 - a[u]] = 0;

    for (int i = head[u]; i != -1; i = next[i]) {
        int v = to[i];
        if (v == p) continue;
        dfs(v, u);
        int temp0 = dp[u][0], temp1 = dp[u][1];
        dp[u][0] = max(temp0, temp0 + dp[v][1] + (a[u] == 1));
        dp[u][1] = max(temp1, temp1 + dp[v][0] + (a[u] == 0));
    }
}

int longestSpecialPath(int n_val, int* a_val, int** edges, int edgesSize, int* edgesColSize){
    n = n_val;
    a = a_val;

    memset(head, -1, sizeof(head));
    edge_cnt = 0;

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        add_edge(u, v);
        add_edge(v, u);
    }

    dfs(0, -1);

    return max(dp[0][0], dp[0][1]);
}