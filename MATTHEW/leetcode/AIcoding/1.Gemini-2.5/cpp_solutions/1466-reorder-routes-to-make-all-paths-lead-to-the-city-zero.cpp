#include <vector>
#include <functional>

class Solution {
public:
    int minReorder(int n, std::vector<std::vector<int>>& connections) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& conn : connections) {
            adj[conn[0]].push_back({conn[1], 1});
            adj[conn[1]].push_back({conn[0], 0});
        }

        int changes = 0;
        std::function<void(int, int)> dfs = 
            [&](int u, int parent) {
            for (const auto& edge : adj[u]) {
                int v = edge.first;
                if (v == parent) {
                    continue;
                }
                changes += edge.second;
                dfs(v, u);
            }
        };

        dfs(0, -1);
        return changes;
    }
};