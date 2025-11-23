#include <vector>
#include <algorithm>

class Solution {
public:
    int maximalNetworkRank(int n, std::vector<std::vector<int>>& roads) {
        std::vector<int> degree(n, 0);
        std::vector<std::vector<bool>> adj(n, std::vector<bool>(n, false));

        for (const auto& road : roads) {
            int u = road[0];
            int v = road[1];
            degree[u]++;
            degree[v]++;
            adj[u][v] = true;
            adj[v][u] = true;
        }

        int max_rank = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int current_rank = degree[i] + degree[j];
                if (adj[i][j]) {
                    current_rank--;
                }
                max_rank = std::max(max_rank, current_rank);
            }
        }

        return max_rank;
    }
};