#include <vector>
#include <utility>
#include <functional>

class Solution {
public:
    std::vector<int> countPairsOfConnectableServers(std::vector<std::vector<int>>& edges, int signalSpeed) {
        int n = edges.size() + 1;
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        std::vector<int> result(n, 0);

        auto dfs = [&](int u, int p, int current_dist, auto& self) -> int {
            int count = (current_dist % signalSpeed == 0);
            for (auto& edge : adj[u]) {
                int v = edge.first;
                int w = edge.second;
                if (v != p) {
                    count += self(v, u, current_dist + w, self);
                }
            }
            return count;
        };

        for (int i = 0; i < n; ++i) {
            if (adj[i].size() < 2) {
                continue;
            }

            int total_pairs = 0;
            int nodes_processed = 0;

            for (auto& edge : adj[i]) {
                int neighbor = edge.first;
                int weight = edge.second;

                int current_count = dfs(neighbor, i, weight, dfs);

                total_pairs += nodes_processed * current_count;
                nodes_processed += current_count;
            }
            result[i] = total_pairs;
        }

        return result;
    }
};