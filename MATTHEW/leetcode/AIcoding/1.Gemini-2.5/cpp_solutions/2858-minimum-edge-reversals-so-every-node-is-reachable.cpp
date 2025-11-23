#include <vector>
#include <functional>
#include <utility>

class Solution {
public:
    std::vector<int> minEdgeReversals(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back({v, 0});
            adj[v].push_back({u, 1});
        }

        std::vector<int> ans(n, 0);

        std::function<void(int, int)> dfs1 = 
            [&](int u, int p) {
            for (auto& edge : adj[u]) {
                int v = edge.first;
                int cost = edge.second;
                if (v == p) continue;
                ans[0] += cost;
                dfs1(v, u);
            }
        };

        if (n > 0) {
            dfs1(0, -1);
        }

        std::function<void(int, int)> dfs2 = 
            [&](int u, int p) {
            for (auto& edge : adj[u]) {
                int v = edge.first;
                int cost = edge.second;
                if (v == p) continue;
                ans[v] = ans[u] + (1 - 2 * cost);
                dfs2(v, u);
            }
        };

        if (n > 0) {
            dfs2(0, -1);
        }

        return ans;
    }
};