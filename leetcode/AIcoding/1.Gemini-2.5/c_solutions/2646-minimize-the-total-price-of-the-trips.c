#include <stdlib.h> // For NULL, though not strictly needed with global arrays
#include <string.h> // For memset, though not strictly needed with explicit initialization
#include <stdio.h>  // For debugging, but not for final solution

#define MAXN 1000
#define MAX_LOGN 10 // ceil(log2(1000)) = 10

struct Edge {
    int to;
    int next;
};
struct Edge adj_edges[2 * (MAXN - 1)]; // Max edges in a tree is N-1, each stored twice
int adj_head[MAXN];
int edge_count;

int parent[MAXN][MAX_LOGN];
int depth[MAXN];
int N_nodes; // Actual number of nodes

long long trip_freq[MAXN];
long long prices_arr[MAXN]; // To store original prices as long long

long long dp[MAXN][2]; // dp[node][0] for not halved, dp[node][1] for halved

long long min(long long a, long long b) {
    return a < b ? a : b;
}

void add_edge(int u, int v) {
    adj_edges[edge_count].to = v;
    adj_edges[edge_count].next = adj_head[u];
    adj_head[u] = edge_count;
    edge_count++;
}

void dfs_lca_setup(int u, int p, int d) {
    depth[u] = d;
    parent[u][0] = p;

    for (int i = adj_head[u]; i != -1; i = adj_edges[i].next) {
        int v = adj_edges[i].to;
        if (v == p) continue;
        dfs_lca_setup(v, u, d + 1);
    }
}

void build_lca_table() {
    for (int k = 1; k < MAX_LOGN; k++) {
        for (int i = 0; i < N_nodes; i++) {
            if (parent[i][k-1] != -1) {
                parent[i][k] = parent[parent[i][k-1]][k-1];
            } else {
                parent[i][k] = -1;
            }
        }
    }
}

int get_lca(int u, int v) {
    if (depth[u] < depth[v]) {
        int temp = u; u = v; v = temp;
    }

    // Lift u to the same depth as v
    for (int k = MAX_LOGN - 1; k >= 0; k--) {
        if (parent[u][k] != -1 && depth[parent[u][k]] >= depth[v]) {
            u = parent[u][k];
        }
    }

    if (u == v) return u;

    // Lift u and v simultaneously
    for (int k = MAX_LOGN - 1; k >= 0; k--) {
        if (parent[u][k] != -1 && parent[v][k] != -1 && parent[u][k] != parent[v][k]) {
            u = parent[u][k];
            v = parent[v][k];
        }
    }
    return parent[u][0];
}

void dfs_propagate_freq(int u, int p) {
    for (int i = adj_head[u]; i != -1; i = adj_edges[i].next) {
        int v = adj_edges[i].to;
        if (v == p) continue;
        dfs_propagate_freq(v, u);
        trip_freq[u] += trip_freq[v];
    }
}

void dfs_dp(int u, int p) {
    dp[u][0] = trip_freq[u] * prices_arr[u];
    dp[u][1] = trip_freq[u] * (prices_arr[u] / 2);

    for (int i = adj_head[u]; i != -1; i = adj_edges[i].next) {
        int v = adj_edges[i].to;
        if (v == p) continue;
        dfs_dp(v, u);
        dp[u][0] += min(dp[v][0], dp[v][1]);
        dp[u][1] += dp[v][0];
    }
}

long long minimizeTotalPrice(int n, int* prices, int pricesSize, int** edges, int edgesSize, int* edgesColSize, int** trips, int tripsSize, int* tripsColSize) {
    N_nodes = n;

    // Initialize adjacency list and global arrays
    for (int i = 0; i < n; i++) {
        adj_head[i] = -1;
        prices_arr[i] = (long long)prices[i];
        trip_freq[i] = 0;
    }
    edge_count = 0;

    // Build adjacency list
    for (int i = 0; i < edgesSize; i++) {
        add_edge(edges[i][0], edges[i][1]);
        add_edge(edges[i][1], edges[i][0]);
    }

    // Initialize parent table for LCA
    for (int i = 0; i < n; i++) {
        for (int k = 0; k < MAX_LOGN; k++) {
            parent[i][k] = -1;
        }
    }

    // LCA setup (assuming node 0 is the root)
    dfs_lca_setup(0, -1, 0);
    build_lca_table();

    // Calculate initial trip frequencies using difference array method
    for (int i = 0; i < tripsSize; i++) {
        int u = trips[i][0];
        int v = trips[i][1];
        int lca = get_lca(u, v);
        trip_freq[u]++;
        trip_freq[v]++;
        trip_freq[lca] -= 2;
    }

    // Propagate trip frequencies from leaves to root to get actual counts
    dfs_propagate_freq(0, -1);

    // Dynamic programming to minimize total price
    dfs_dp(0, -1);

    return min(dp[0][0], dp[0][1]);
}