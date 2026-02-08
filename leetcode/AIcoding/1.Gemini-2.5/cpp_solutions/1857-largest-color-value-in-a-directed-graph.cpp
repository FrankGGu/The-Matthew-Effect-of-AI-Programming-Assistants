#include <vector>
#include <string>
#include <queue>
#include <algorithm> // For std::max

class Solution {
public:
    int largestPathValue(std::string colors, std::vector<std::vector<int>>& edges) {
        int n = colors.length();
        std::vector<std::vector<int>> adj(n);
        std::vector<int> in_degree(n, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            in_degree[v]++;
        }

        std::vector<std::vector<int>> dp(n, std::vector<int>(26, 0));
        std::queue<int> q;

        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                q.push(i);
            }
        }

        int max_color_value = 0;
        int visited_nodes_count = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            visited_nodes_count++;

            dp[u][colors[u] - 'a']++;

            for (int c = 0; c < 26; ++c) {
                max_color_value = std::max(max_color_value, dp[u][c]);
            }

            for (int v : adj[u]) {
                for (int c = 0; c < 26; ++c) {
                    dp[v][c] = std::max(dp[v][c], dp[u][c]);
                }
                in_degree[v]--;
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (visited_nodes_count != n) {
            return -1;
        }

        return max_color_value;
    }
};