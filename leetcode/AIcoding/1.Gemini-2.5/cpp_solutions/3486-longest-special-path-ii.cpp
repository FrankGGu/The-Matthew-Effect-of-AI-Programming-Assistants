#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> dp;
    std::vector<int> visited_state; // 0: unvisited, 1: visiting (in current path), 2: visited (computed)

    int longestSpecialPathII(int n, const std::vector<std::vector<int>>& edges) {
        adj.assign(n, std::vector<int>());
        dp.assign(n, 0);
        visited_state.assign(n, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
        }

        int max_len = 0;
        for (int i = 0; i < n; ++i) {
            max_len = std::max(max_len, dfs(i));
        }
        return max_len;
    }

    int dfs(int u) {
        if (visited_state[u] == 1) {
            return 0;
        }
        if (visited_state[u] == 2) {
            return dp[u];
        }

        visited_state[u] = 1;

        int current_path_len = 1;

        for (int v : adj[u]) {
            current_path_len = std::max(current_path_len, 1 + dfs(v));
        }

        visited_state[u] = 2;
        return dp[u] = current_path_len;
    }
};