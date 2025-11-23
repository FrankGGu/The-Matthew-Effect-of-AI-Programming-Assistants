#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 100005

int adj[MAXN];
int adj_next[MAXN];
int adj_head[MAXN];
int adj_cnt;

int val[MAXN];

int n;
int m;

int dp[MAXN][2];

void add_edge(int u, int v) {
    adj[adj_cnt] = v;
    adj_next[adj_cnt] = adj_head[u];
    adj_head[u] = adj_cnt++;
}

int dfs(int u, int p) {
    if (dp[u][p] != -1) {
        return dp[u][p];
    }

    int max_path = 0;
    for (int i = adj_head[u]; i != -1; i = adj_next[i]) {
        int v = adj[i];
        if (v == u) continue;

        int path_len = dfs(v, 1 - p) + 1;
        if (val[u] == p)
        {
            if(val[v] != 1-p)
            {
                path_len = -1e9;
            }
        } else {
            if(val[v] != 1-p)
            {
                path_len = -1e9;
            }
        }
        max_path = (max_path > path_len) ? max_path : path_len;
    }

    return dp[u][p] = max_path;
}

int longestSpecialPath(int n_arg, int* values, int** edges, int edgesSize, int* edgesColSize) {
    n = n_arg;
    m = edgesSize;

    memset(adj_head, -1, sizeof(adj_head));
    adj_cnt = 0;

    for (int i = 0; i < n; i++) {
        val[i] = values[i];
    }

    for (int i = 0; i < m; i++) {
        add_edge(edges[i][0], edges[i][1]);
        add_edge(edges[i][1], edges[i][0]);
    }

    int max_len = -1;
    for (int i = 0; i < n; i++) {
        memset(dp, -1, sizeof(dp));
        int len0 = dfs(i, 0);
        memset(dp, -1, sizeof(dp));
        int len1 = dfs(i, 1);

        if(len0 > -1e8){
            max_len = (max_len > len0) ? max_len : len0;
        }
        if(len1 > -1e8){
            max_len = (max_len > len1) ? max_len : len1;
        }
    }

    return max_len;
}