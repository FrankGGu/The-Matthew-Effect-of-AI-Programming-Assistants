#include <stdlib.h> // For malloc, free, calloc
#include <string.h> // For memset (optional, can use loop for initialization)

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long* dfs(int u, int p, int k_max, int* coins, int** adj, int* adj_sizes) {
    // dp_combined_children[j] will store max points from children's subtrees using j operations
    long long* dp_combined_children = (long long*)malloc(sizeof(long long) * (k_max + 1));
    for (int i = 0; i <= k_max; ++i) {
        dp_combined_children[i] = -1; // Initialize to -1 (unreachable)
    }
    // Base case for dp_combined_children: 0 points, 0 operations used if no children or all children contribute 0 operations and 0 points.
    // This serves as the starting point for summing up points from children.
    dp_combined_children[0] = 0; 

    // Iterate over each child of the current node u
    for (int i = 0; i < adj_sizes[u]; ++i) {
        int v = adj[u][i];
        if (v == p) continue; // Skip parent to avoid going back up the tree

        // Recursively call DFS for the child v
        long long* dp_v = dfs(v, u, k_max, coins, adj, adj_sizes);

        // Merge dp_combined_children (results from children processed so far) with dp_v (results from current child v)
        long long* new_dp_combined_children = (long long*)malloc(sizeof(long long) * (k_max + 1));
        for (int j = 0; j <= k_max; ++j) {
            new_dp_combined_children[j] = -1; // Initialize new array
        }

        // Iterate through all possible operation counts for the current combined children
        for (int j_current = 0; j_current <= k_max; ++j_current) {
            if (dp_combined_children[j_current] == -1) continue; // Skip unreachable states

            // Iterate through all possible operation counts for the current child v
            for (int j_child = 0; j_child <= k_max - j_current; ++j_child) { // Ensure total operations don't exceed k_max
                if (dp_v[j_child] == -1) continue; // Skip unreachable states

                long long current_total_ops = j_current + j_child;
                long long current_total_points = dp_combined_children[j_current] + dp_v[j_child];

                // Update the new combined DP array if a better result is found
                if (new_dp_combined_children[current_total_ops] == -1 || 
                    new_dp_combined_children[current_total_ops] < current_total_points) {
                    new_dp_combined_children[current_total_ops] = current_total_points;
                }
            }
        }
        free(dp_combined_children); // Free the old combined DP array
        dp_combined_children = new_dp_combined_children; // Update with the new merged results
        free(dp_v); // Free the DP array returned by the child's DFS call
    }

    // After processing all children, dp_combined_children holds the max points from all children's subtrees.
    // Now, we need to combine this with the choices for node u itself.
    long long* final_dp_u = (long long*)malloc(sizeof(long long) * (k_max + 1));
    for (int i = 0; i <= k_max; ++i) {
        final_dp_u[i] = -1; // Initialize final DP array for node u
    }

    // Iterate through all possible operation counts from children's subtrees
    for (int j_children = 0; j_children <= k_max; ++j_children) {
        if (dp_combined_children[j_children] == -1) continue; // Skip unreachable states

        // Option 1 for node u: Don't halve coins[u]
        // Total operations remain j_children
        // Total points: points from children + coins[u]
        long long points_no_halve = dp_combined_children[j_children] + (long long)coins[u];
        if (final_dp_u[j_children] == -1 || final_dp_u[j_children] < points_no_halve) {
            final_dp_u[j_children] = points_no_halve;
        }

        // Option 2 for node u: Halve coins[u]
        // Total operations: j_children + 1 (if within budget)
        // Total points: points from children + floor(coins[u] / 2)
        if (j_children + 1 <= k_max) {
            long long points_halve = dp_combined_children[j_children] + (long long)coins[u] / 2;
            if (final_dp_u[j_children + 1] == -1 || final_dp_u[j_children + 1] < points_halve) {
                final_dp_u[j_children + 1] = points_halve;
            }
        }
    }

    free(dp_combined_children); // Free the temporary array used for combining children's results
    return final_dp_u; // Return the final DP array for the subtree rooted at u
}

long long maximumPoints(int n, int** edges, int edgesSize, int* edgesColSize, int* coins, int k) {
    if (n == 0) return 0; // Handle empty tree case

    // Build adjacency list for the tree
    int** adj = (int**)malloc(sizeof(int*) * n);
    int* adj_sizes = (int*)calloc(n, sizeof(int)); // Use calloc to initialize sizes to 0

    // First pass: Count degrees for each node to allocate memory for adjacency lists
    for (int i = 0; i < edgesSize; ++i) {
        adj_sizes[edges[i][0]]++;
        adj_sizes[edges[i][1]]++;
    }

    // Allocate memory for each node's adjacency list
    for (int i = 0; i < n; ++i) {
        adj[i] = (int*)malloc(sizeof(int) * adj_sizes[i]);
        adj_sizes[i] = 0; // Reset sizes to 0 for the second pass (to be used as current index)
    }

    // Second pass: Fill the adjacency lists
    for (int i = 0; i < edgesSize; ++i) {
        int u = edges[i][0];
        int v = edges[i][1];
        adj[u][adj_sizes[u]++] = v;
        adj[v][adj_sizes[v]++] = u;
    }

    // Start DFS from node 0 (arbitrary root for a tree), with parent -1
    long long* final_dp = dfs(0, -1, k, coins, adj, adj_sizes);

    long long max_points = 0;
    // The problem asks for maximum points using AT MOST k operations.
    // So we need to find the maximum value among all final_dp[i] for i from 0 to k.
    for (int i = 0; i <= k; ++i) {
        if (final_dp[i] != -1 && final_dp[i] > max_points) {
            max_points = final_dp[i];
        }
    }
    // Note: Since coins[i] are positive, at least final_dp[0] (no operations) will be valid and positive,
    // so max_points will always be at least the sum of all coins.

    // Free all dynamically allocated memory
    free(final_dp);
    for (int i = 0; i < n; ++i) {
        free(adj[i]);
    }
    free(adj);
    free(adj_sizes);

    return max_points;
}