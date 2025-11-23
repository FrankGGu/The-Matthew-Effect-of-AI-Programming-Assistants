#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

class Solution {
public:
    int reachableNodes(std::vector<std::vector<int>>& edges, int maxMoves_int, int n) {
        long long maxMoves = maxMoves_int;

        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cnt = edge[2];
            adj[u].push_back({v, cnt});
            adj[v].push_back({u, cnt});
        }

        std::vector<long long> dist(n, std::numeric_limits<long long>::max());
        std::priority_queue<std::pair<long long, int>> pq;

        dist[0] = 0;
        pq.push({0, 0});

        while (!pq.empty()) {
            long long current_moves = -pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (current_moves > dist[u]) {
                continue;
            }

            for (const auto& neighbor_pair : adj[u]) {
                int v = neighbor_pair.first;
                int cnt = neighbor_pair.second;
                long long edge_weight = (long long)cnt + 1;

                if (dist[u] + edge_weight < dist[v]) {
                    dist[v] = dist[u] + edge_weight;
                    pq.push({-dist[v], v});
                }
            }
        }

        int total_reachable_nodes = 0;

        for (int i = 0; i < n; ++i) {
            if (dist[i] <= maxMoves) {
                total_reachable_nodes++;
            }
        }

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cnt = edge[2];

            long long reachable_new_nodes_from_u = 0;
            if (dist[u] <= maxMoves) {
                reachable_new_nodes_from_u = std::min((long long)cnt, maxMoves - dist[u]);
            }

            long long reachable_new_nodes_from_v = 0;
            if (dist[v] <= maxMoves) {
                reachable_new_nodes_from_v = std::min((long long)cnt, maxMoves - dist[v]);
            }

            total_reachable_nodes += std::min((long long)cnt, reachable_new_nodes_from_u + reachable_new_nodes_from_v);
        }

        return total_reachable_nodes;
    }
};