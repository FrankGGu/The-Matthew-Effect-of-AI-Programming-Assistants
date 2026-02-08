#include <vector>
#include <algorithm>

class Solution {
public:
    long long maxWeightedKEdgePath(int n, std::vector<std::vector<int>>& edges, int k) {
        // dp[i][j] represents the maximum weight of a path with exactly 'i' edges ending at node 'j'.
        // Initialize with a very small number to represent unreachable states.
        // Using -1e18 as a sufficiently small long long value.
        std::vector<std::vector<long long>> dp(k + 1, std::vector<long long>(n, -1e18));

        // Base case: A path with 0 edges has 0 weight.
        // Any node can be a starting point with 0 edges and 0 weight.
        for (int i = 0; i < n; ++i) {
            dp[0][i] = 0;
        }

        // Iterate for each number of edges from 1 to k
        for (int i = 1; i <= k; ++i) {
            // Iterate through all edges in the graph
            for (const auto& edge : edges) {
                int u = edge[0]; // Start node of the edge
                int v = edge[1]; // End node of the edge
                int weight = edge[2]; // Weight of the edge

                // If node 'u' was reachable with 'i-1' edges,
                // then node 'v' can be reached with 'i' edges by taking the edge (u, v).
                if (dp[i - 1][u] != -1e18) {
                    dp[i][v] = std::max(dp[i][v], dp[i - 1][u] + weight);
                }
            }
        }

        // After filling the DP table, find the maximum weight among all paths with exactly 'k' edges.
        long long max_weight = -1e18;
        for (int i = 0; i < n; ++i) {
            max_weight = std::max(max_weight, dp[k][i]);
        }

        // If 'max_weight' is still -1e18, it means no path of 'k' edges was found.
        // The problem typically asks to return -1 in such cases.
        if (max_weight == -1e18) {
            return -1;
        }

        return max_weight;
    }
};