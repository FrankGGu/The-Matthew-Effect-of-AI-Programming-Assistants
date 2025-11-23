#include <limits.h> // For LLONG_MAX
#include <stdlib.h> // For malloc, free

long long min(long long a, long long b) {
    return (a < b) ? a : b;
}

long long findMinimumCost(int n, int** costs) {
    // dp[mask][last_node][first_node] stores the minimum cost of a path
    // p[0], p[1], ..., p[k-1] such that:
    // - 'mask' is the bitmask representing the set of nodes {p[0], ..., p[k-1]}
    // - 'last_node' is p[k-1]
    // - 'first_node' is p[0]
    // - 'k' is the number of nodes in the path, which is __builtin_popcount(mask)
    // The cost accumulated is sum_{j=0}^{k-2} (j+1) * cost[p[j]][p[j+1]]
    long long*** dp = (long long***)malloc((1 << n) * sizeof(long long**));
    for (int i = 0; i < (1 << n); ++i) {
        dp[i] = (long long**)malloc(n * sizeof(long long*));
        for (int j = 0; j < n; ++j) {
            dp[i][j] = (long long*)malloc(n * sizeof(long long));
            for (int k = 0; k < n; ++k) {
                dp[i][j][k] = LLONG_MAX; // Initialize with a large value representing infinity
            }
        }
    }

    // Base cases: A path of length 1 (just the first node).
    // No edges have been traversed yet, so the accumulated cost is 0.
    // Any node 'i' can be the starting node p[0].
    for (int i = 0; i < n; ++i) {
        dp[1 << i][i][i] = 0;
    }

    // Iterate over masks from 1 to (1 << n) - 1
    // Masks are processed in increasing order, ensuring that dp values for smaller masks are computed first.
    for (int mask = 1; mask < (1 << n); ++mask) {
        int k = __builtin_popcount(mask); // Current number of nodes in the path (p[0]...p[k-1])

        // If all 'n' nodes are already in the mask, we cannot extend the path further in this loop.
        // We will handle the final cycle-closing edge separately.
        if (k == n) continue; 

        // Iterate over all possible 'last_node's in the current path
        for (int last_node = 0; last_node < n; ++last_node) {
            // 'last_node' must be part of the current 'mask'
            if (!((mask >> last_node) & 1)) continue;

            // Iterate over all possible 'first_node's of the current path
            for (int first_node = 0; first_node < n; ++first_node) {
                // 'first_node' must also be part of the current 'mask'
                if (!((mask >> first_node) & 1)) continue;

                // If this DP state is unreachable (cost is infinity), skip it
                if (dp[mask][last_node][first_node] == LLONG_MAX) continue;

                // The next edge to be added will be the k-th edge (0-indexed, from p[k-1] to p[k]).
                // According to the problem definition, its multiplier will be 'k'.
                long long multiplier_for_next_edge = (long long)k;

                // Try to extend the path by adding a 'next_node'
                for (int next_node = 0; next_node < n; ++next_node) {
                    // 'next_node' must not be in the current 'mask' (i.e., not yet visited)
                    if (!((mask >> next_node) & 1)) {
                        int new_mask = mask | (1 << next_node); // Create the new mask with 'next_node' included
                        long long current_path_cost = dp[mask][last_node][first_node];
                        long long edge_contribution = multiplier_for_next_edge * costs[last_node][next_node];

                        // Update the DP table for the new state (new_mask, next_node, first_node)
                        dp[new_mask][next_node][first_node] = min(dp[new_mask][next_node][first_node], current_path_cost + edge_contribution);
                    }
                }
            }
        }
    }

    long long min_total_cost = LLONG_MAX;

    // After filling the DP table for all paths of length 'n' (i.e., all nodes visited),
    // calculate the total cost by adding the final edge that closes the cycle.
    // The DP state dp[(1 << n) - 1][last_node][first_node] contains the sum:
    // sum_{j=0}^{n-2} (j+1) * cost[p[j]][p[j+1]]
    // We need to add the last term of the cycle: (n-1+1) * cost[p[n-1]][p[0]] = n * cost[p[n-1]][p[0]].
    int final_mask = (1 << n) - 1; // Mask with all bits set, indicating all nodes have been visited
    for (int last_node = 0; last_node < n; ++last_node) {
        for (int first_node = 0; first_node < n; ++first_node) {
            // If a complete path (all nodes visited) ending at 'last_node' and starting at 'first_node' is reachable
            if (dp[final_mask][last_node][first_node] != LLONG_MAX) {
                long long current_path_cost = dp[final_mask][last_node][first_node];
                long long final_edge_contribution = (long long)n * costs[last_node][first_node];

                // Update the overall minimum total cost
                min_total_cost = min(min_total_cost, current_path_cost + final_edge_contribution);
            }
        }
    }

    // Free allocated memory to prevent memory leaks
    for (int i = 0; i < (1 << n); ++i) {
        for (int j = 0; j < n; ++j) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return min_total_cost;
}