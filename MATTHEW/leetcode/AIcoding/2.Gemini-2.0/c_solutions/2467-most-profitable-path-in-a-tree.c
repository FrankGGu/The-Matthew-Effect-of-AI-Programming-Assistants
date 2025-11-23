#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 10000

int adj[MAXN][2];
int adj_size[MAXN];
int amount[MAXN];
int bob_dist[MAXN];
int alice_dist[MAXN];
int visited[MAXN];
int ans;
int n;

void dfs_bob(int u, int p, int d) {
    bob_dist[u] = d;
    if (u == 0) return;
    for (int i = 0; i < adj_size[u]; i++) {
        int v = adj[u][i];
        if (v != p) {
            dfs_bob(v, u, d + 1);
        }
    }
}

void dfs_alice(int u, int p, int d) {
    alice_dist[u] = d;
    for (int i = 0; i < adj_size[u]; i++) {
        int v = adj[u][i];
        if (v != p) {
            dfs_alice(v, u, d + 1);
        }
    }
}

void dfs(int u, int p, int current_sum) {
    visited[u] = 1;
    current_sum += amount[u];

    if (adj_size[u] == 1 && p != -1) {
        ans = (current_sum > ans) ? current_sum : ans;
        return;
    }

    for (int i = 0; i < adj_size[u]; i++) {
        int v = adj[u][i];
        if (v != p) {
            dfs(v, u, current_sum);
        }
    }
}

int mostProfitablePath(int n_val, int** edges, int edgesSize, int* edgesColSize, int* amount_val, int amountSize) {
    n = n_val;
    for (int i = 0; i < n; i++) {
        adj_size[i] = 0;
        amount[i] = amount_val[i];
        bob_dist[i] = INT_MAX;
        alice_dist[i] = INT_MAX;
        visited[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_size[u]++] = v;
        adj[v][adj_size[v]++] = u;
    }

    dfs_bob(0, -1, 0);
    dfs_alice(0, -1, 0);

    for (int i = 0; i < n; i++) {
        if (alice_dist[i] < bob_dist[i]) {
            amount[i] = 0;
        } else if (alice_dist[i] == bob_dist[i]) {
            amount[i] /= 2;
        }
    }

    ans = INT_MIN;
    dfs(0, -1, 0);

    return ans;
}