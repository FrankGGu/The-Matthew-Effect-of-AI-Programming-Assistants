#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> disc;
    std::vector<int> low;
    std::vector<bool> visited;
    int time;
    std::vector<std::vector<int>> bridges;

    void dfs(int u, int parent) {
        visited[u] = true;
        disc[u] = low[u] = time++;

        for (int v : adj[u]) {
            if (v == parent) {
                continue;
            }
            if (visited[v]) {
                low[u] = std::min(low[u], disc[v]);
            } else {
                dfs(v, u);
                low[u] = std::min(low[u], low[v]);
                if (low[v] > disc[u]) {
                    bridges.push_back({u, v});
                }
            }
        }
    }

    std::vector<std::vector<int>> criticalConnections(int n, std::vector<std::vector<int>>& connections) {
        adj.resize(n);
        disc.assign(n, -1);
        low.assign(n, -1);
        visited.assign(n, false);
        time = 0;
        bridges.clear();

        for (const auto& conn : connections) {
            adj[conn[0]].push_back(conn[1]);
            adj[conn[1]].push_back(conn[0]);
        }

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i, -1);
            }
        }

        return bridges;
    }
};