#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long dfs(int node, int parent, int* price, int n, int** adj, int* adjSize) {
    long long max_sum = price[node];
    for (int i = 0; i < adjSize[node]; i++) {
        int neighbor = adj[node][i];
        if (neighbor != parent) {
            long long sum = dfs(neighbor, node, price, n, adj, adjSize);
            if (sum > 0) {
                max_sum += sum;
            }
        }
    }
    return max_sum;
}

long long max(long long a, long long b) {
    return (a > b) ? a : b;
}

long long max_path_sum(int start_node, int* price, int n, int** adj, int* adjSize) {
    return dfs(start_node, -1, price, n, adj, adjSize);
}

long long max_path_sum_all_nodes(int* price, int n, int** adj, int* adjSize) {
    long long max_sum = 0;
    for (int i = 0; i < n; i++) {
        max_sum = max(max_sum, max_path_sum(i, price, n, adj, adjSize));
    }
    return max_sum;
}

long long max_price_sum(int* price, int n) {
    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += price[i];
    }
    return sum;
}

long long max_star_sum(int* price, int n, int** adj, int* adjSize) {
    long long max_sum = 0;
    for (int i = 0; i < n; i++) {
        long long current_sum = price[i];
        long long max_neighbor_price = 0;
        for (int j = 0; j < adjSize[i]; j++) {
            if (price[adj[i][j]] > max_neighbor_price) {
                max_neighbor_price = price[adj[i][j]];
            }
        }
        current_sum += max_neighbor_price;
        max_sum = max(max_sum, current_sum);
    }
    return max_sum;
}

long long max_star_sum_rooted(int root, int* price, int n, int** adj, int* adjSize) {
    long long sum = price[root];
    long long max_neighbor = 0;
    for (int i = 0; i < adjSize[root]; i++) {
        if (price[adj[root][i]] > max_neighbor) {
            max_neighbor = price[adj[root][i]];
        }
    }
    sum += max_neighbor;
    return sum;
}

long long max_star_sum_all_nodes(int* price, int n, int** adj, int* adjSize) {
    long long max_sum = 0;
    for (int i = 0; i < n; i++) {
        max_sum = max(max_sum, max_star_sum_rooted(i, price, n, adj, adjSize));
    }
    return max_sum;
}

long long max_path_sum_optimized(int start_node, int* price, int n, int** adj, int* adjSize) {
    long long max_sum = 0;
    long long* dp = (long long*)malloc(n * sizeof(long long));
    for (int i = 0; i < n; i++) {
        dp[i] = 0;
    }

    long long dfs_optimized(int node, int parent) {
        if (dp[node] != 0) {
            return dp[node];
        }

        long long current_sum = price[node];
        long long max_child_sum = 0;

        for (int i = 0; i < adjSize[node]; i++) {
            int neighbor = adj[node][i];
            if (neighbor != parent) {
                long long child_sum = dfs_optimized(neighbor, node);
                if (child_sum > 0) {
                    max_child_sum += child_sum;
                }
            }
        }

        dp[node] = current_sum + max_child_sum;
        return dp[node];
    }

    max_sum = dfs_optimized(start_node, -1);
    free(dp);
    return max_sum;
}

long long max_path_sum_all_nodes_optimized(int* price, int n, int** adj, int* adjSize) {
    long long max_sum = 0;
    for (int i = 0; i < n; i++) {
        max_sum = max(max_sum, max_path_sum_optimized(i, price, n, adj, adjSize));
    }
    return max_sum;
}

long long differenceOfMaxSum(int n, int* price, int** edges, int edgesSize, int* edgesColSize) {
    int** adj = (int**)malloc(n * sizeof(int*));
    int* adjSize = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        adj[i] = (int*)malloc(n * sizeof(int));
        adjSize[i] = 0;
    }

    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adjSize[u]++] = v;
        adj[v][adjSize[v]++] = u;
    }

    long long max_sum = max_price_sum(price, n);
    long long max_path = max_path_sum_all_nodes_optimized(price, n, adj, adjSize);

    for (int i = 0; i < n; i++) {
        free(adj[i]);
    }
    free(adj);
    free(adjSize);

    return max_sum - max_path;
}