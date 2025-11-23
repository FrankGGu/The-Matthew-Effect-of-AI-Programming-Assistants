#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

class Solution {
public:
    std::vector<long long> dijkstra(int start_node, int n, const std::vector<std::vector<std::pair<int, int>>>& adj) {
        std::vector<long long> dist(n, std::numeric_limits<long long>::max());
        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> pq;

        dist[start_node] = 0;
        pq.push({0, start_node});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) {
                continue;
            }

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;
                if (dist[u] != std::numeric_limits<long long>::max() && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }
        return dist;
    }

    long long minimumWeight(int n, std::vector<std::vector<int>>& edges, int src1, int src2, int dest) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        std::vector<std::vector<std::pair<int, int>>> rev_adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            rev_adj[v].push_back({u, w});
        }

        std::vector<long long> dist_src1 = dijkstra(src1, n, adj);
        std::vector<long long> dist_src2 = dijkstra(src2, n, adj);
        std::vector<long long> dist_dest_rev = dijkstra(dest, n, rev_adj); // This gives dist from any node 'i' to 'dest'

        long long min_total_weight = std::numeric_limits<long long>::max();

        for (int m = 0; m < n; ++m) {
            if (dist_src1[m] != std::numeric_limits<long long>::max() &&
                dist_src2[m] != std::numeric_limits<long long>::max() &&
                dist_dest_rev[m] != std::numeric_limits<long long>::max()) {

                long long current_total_weight = dist_src1[m] + dist_src2[m] + dist_dest_rev[m];
                min_total_weight = std::min(min_total_weight, current_total_weight);
            }
        }

        return (min_total_weight == std::numeric_limits<long long>::max()) ? -1 : min_total_weight;
    }
};