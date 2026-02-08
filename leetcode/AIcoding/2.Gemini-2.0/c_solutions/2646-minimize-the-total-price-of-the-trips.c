#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXN 10001

int min(int a, int b) {
    return (a < b) ? a : b;
}

int dfs(int node, int end, int parent, int* path, int path_len, int* prices, int** adj, int* adj_sizes, int* count) {
    path[path_len++] = node;

    if (node == end) {
        for (int i = 0; i < path_len; i++) {
            count[path[i]]++;
        }
        return 1;
    }

    for (int i = 0; i < adj_sizes[node]; i++) {
        int neighbor = adj[node][i];
        if (neighbor != parent) {
            if (dfs(neighbor, end, node, path, path_len, prices, adj, adj_sizes, count)) {
                return 1;
            }
        }
    }

    return 0;
}

int solve(int n, int** adj, int* adj_sizes, int* prices, int** trips, int tripsSize, int* tripsColSize) {
    int* count = (int*)calloc(n, sizeof(int));
    int* path = (int*)malloc(n * sizeof(int));

    for (int i = 0; i < tripsSize; i++) {
        dfs(trips[i][0], trips[i][1], -1, path, 0, prices, adj, adj_sizes, count);
    }

    int* dp = (int*)malloc(n * sizeof(int));
    int* dp_half = (int*)malloc(n * sizeof(int));
    bool* visited = (bool*)calloc(n, sizeof(bool));

    void postorder(int node) {
        visited[node] = true;
        dp[node] = prices[node] * count[node];
        dp_half[node] = prices[node] * count[node] / 2;

        int sum_dp = 0;
        int sum_dp_half = 0;

        for (int i = 0; i < adj_sizes[node]; i++) {
            int neighbor = adj[node][i];
            if (!visited[neighbor]) {
                postorder(neighbor);
                sum_dp += min(dp[neighbor], dp_half[neighbor]);
                sum_dp_half += dp[neighbor];
            }
        }

        dp[node] += sum_dp;
        dp_half[node] += sum_dp_half;
    }

    postorder(0);

    int result = min(dp[0], dp_half[0]);

    free(count);
    free(path);
    free(dp);
    free(dp_half);
    free(visited);

    return result;
}

int minimumTotalPrice(int n, int** edges, int edgesSize, int* edgesColSize, int* price, int priceSize, int** trips, int tripsSize, int* tripsColSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adj_sizes = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_sizes[u]++] = v;
        adj[v][adj_sizes[v]++] = u;
    }

    int result = solve(n, adj, adj_sizes, price, trips, tripsSize, tripsColSize);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);

    return result;
}