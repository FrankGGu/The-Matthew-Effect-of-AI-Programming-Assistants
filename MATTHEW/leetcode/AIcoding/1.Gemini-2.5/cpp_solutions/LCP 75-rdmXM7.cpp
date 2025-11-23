#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

class Solution {
public:
    long long minCost(int n, std::vector<std::vector<int>>& edges, int k, int t, int start, int end) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];
            adj[u].push_back({v, weight});
            adj[v].push_back({u, weight}); // Assuming an undirected graph. Remove this line if the graph is directed.
        }

        std::vector<std::vector<long long>> dp(k + 1, std::vector<long long>(n, std::numeric_limits<long long>::max()));

        dp[0][start] = 0;

        for (int i = 0; i <= k; ++i) {
            std::priority_queue<std::pair<long long, int>, 
                                std::vector<std::pair<long long, int>>, 
                                std::greater<std::pair<long long, int>>> pq;

            for (int u = 0; u < n; ++u) {
                if (dp[i][u] != std::numeric_limits<long long>::max()) {
                    pq.push({dp[i][u], u});
                }
            }

            while (!pq.empty()) {
                long long current_cost = pq.top().first;
                int u = pq.top().second;
                pq.pop();

                if (current_cost > dp[i][u]) {
                    continue;
                }

                for (const auto& edge : adj[u]) {
                    int v = edge.first;
                    int weight = edge.second;
                    // Check for overflow before addition and update
                    if (dp[i][u] != std::numeric_limits<long long>::max() && dp[i][u] + weight < dp[i][v]) {
                        dp[i][v] = dp[i][u] + weight;
                        pq.push({dp[i][v], v});
                    }
                }
            }

            if (i < k) {
                long long min_cost_to_teleport_from_this_layer = std::numeric_limits<long long>::max();
                for (int u = 0; u < n; ++u) {
                    min_cost_to_teleport_from_this_layer = std::min(min_cost_to_teleport_from_this_layer, dp[i][u]);
                }

                if (min_cost_to_teleport_from_this_layer != std::numeric_limits<long long>::max()) {
                    for (int v = 0; v < n; ++v) {
                        dp[i+1][v] = std::min(dp[i+1][v], min_cost_to_teleport_from_this_layer + t);
                    }
                }
            }
        }

        long long min_total_cost = std::numeric_limits<long long>::max();
        for (int i = 0; i <= k; ++i) {
            min_total_cost = std::min(min_total_cost, dp[i][end]);
        }

        return min_total_cost == std::numeric_limits<long long>::max() ? -1 : min_total_cost;
    }
};