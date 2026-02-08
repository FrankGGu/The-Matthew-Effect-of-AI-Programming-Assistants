#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<bool> visited;
    long long current_component_nodes;
    long long current_component_sum_degrees;

    void dfs(int u) {
        visited[u] = true;
        current_component_nodes++;
        current_component_sum_degrees += adj[u].size();

        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v);
            }
        }
    }

    int countCompleteComponents(int n, std::vector<std::vector<int>>& edges) {
        adj.resize(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        visited.resize(n, false);
        int complete_components_count = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                current_component_nodes = 0;
                current_component_sum_degrees = 0;

                dfs(i);

                long long num_edges_in_component = current_component_sum_degrees / 2;

                if (num_edges_in_component == current_component_nodes * (current_component_nodes - 1) / 2) {
                    complete_components_count++;
                }
            }
        }

        return complete_components_count;
    }
};