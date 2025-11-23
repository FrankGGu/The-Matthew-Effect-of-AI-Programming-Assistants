#include <vector>
#include <queue>
#include <algorithm> // For std::max and std::max_element

class Solution {
public:
    int maxProfit(int n, std::vector<int>& profits, std::vector<std::vector<int>>& dependencies) {
        // Handle the case where there are no items
        if (n == 0) {
            return 0;
        }

        // Build adjacency list and compute in-degrees for each node
        std::vector<std::vector<int>> adj(n);
        std::vector<int> in_degree(n, 0);

        for (const auto& dep : dependencies) {
            int u = dep[0];
            int v = dep[1];
            adj[u].push_back(v);
            in_degree[v]++;
        }

        // Initialize DP array: dp[i] will store the maximum profit of a path ending at node i
        // Initially, a path ending at node i just includes node i itself.
        std::vector<int> dp(n);
        for (int i = 0; i < n; ++i) {
            dp[i] = profits[i];
        }

        // Initialize a queue for topological sort (Kahn's algorithm)
        // Add all nodes with an in-degree of 0 to the queue. These are potential starting points for paths.
        std::queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        // Perform topological sort and update DP values
        while (!q.empty()) {
            int u = q.front();
            q.pop();

            // For each neighbor v of u
            for (int v : adj[u]) {
                // Update dp[v]: The maximum profit of a path ending at v could be
                // either its current value (from another predecessor) or the profit
                // of a path ending at u plus the profit of v itself.
                dp[v] = std::max(dp[v], dp[u] + profits[v]);

                // Decrement the in-degree of v as u (one of its prerequisites) has been processed
                in_degree[v]--;

                // If all prerequisites of v have been processed, add v to the queue
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        // The maximum profit will be the maximum value found in the dp array.
        // This represents the maximum profit of any valid path in the DAG.
        int max_overall_profit = 0;
        // If n > 0, find the maximum element in dp. If all profits are negative, this will be the largest negative.
        // If the problem implies we can choose to select no items for a profit of 0, then we would take std::max(0, *std::max_element(dp.begin(), dp.end())).
        // However, the standard interpretation of "maximum profit" typically means finding the best path, even if it's negative.
        // For n > 0, dp is guaranteed to have elements.
        max_overall_profit = *std::max_element(dp.begin(), dp.end());

        return max_overall_profit;
    }
};