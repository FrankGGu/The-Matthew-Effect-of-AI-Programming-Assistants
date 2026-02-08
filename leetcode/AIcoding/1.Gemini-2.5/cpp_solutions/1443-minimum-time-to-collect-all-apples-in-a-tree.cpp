#include <vector>
#include <numeric>

class Solution {
public:
    int dfs(int u, int p, const std::vector<std::vector<int>>& adj, const std::vector<bool>& hasApple) {
        int time_from_subtree = 0;

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }

            int child_time = dfs(v, u, adj, hasApple);

            if (child_time > 0 || hasApple[v]) {
                time_from_subtree += child_time + 2;
            }
        }

        return time_from_subtree;
    }

    int minTime(int n, std::vector<std::vector<int>>& edges, std::vector<bool>& hasApple) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        return dfs(0, -1, adj, hasApple);
    }
};