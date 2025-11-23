#include <vector>
#include <numeric>

class Solution {
public:
    void dfs(int u, const std::vector<std::vector<int>>& adj, std::vector<bool>& visited, long long& current_component_size) {
        visited[u] = true;
        current_component_size++;
        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, adj, visited, current_component_size);
            }
        }
    }

    long long countPairs(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<bool> visited(n, false);
        long long total_unreachable_pairs = 0;
        long long nodes_processed_so_far = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                long long current_component_size = 0;
                dfs(i, adj, visited, current_component_size);

                total_unreachable_pairs += current_component_size * nodes_processed_so_far;

                nodes_processed_so_far += current_component_size;
            }
        }

        return total_unreachable_pairs;
    }
};