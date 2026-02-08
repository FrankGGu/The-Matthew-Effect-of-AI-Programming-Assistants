#include <vector>
#include <queue>
#include <limits>
#include <algorithm>

class Solution {
public:
    const long long INF = std::numeric_limits<long long>::max();

    void dijkstra(int start_node, int n, const std::vector<std::vector<std::pair<int, int>>>& graph, std::vector<long long>& dist) {
        dist.assign(n, INF);
        dist[start_node] = 0;

        // Priority queue stores pairs of {distance, node}
        // Use std::greater for min-priority queue
        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> pq;
        pq.push({0, start_node});

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();

            // If we found a shorter path to u already, skip this one
            if (d > dist[u]) {
                continue;
            }

            // Explore neighbors
            for (auto& edge : graph[u]) {
                int v = edge.first;
                int weight = edge.second;

                // Check for overflow before adding, though dist[u] != INF already handles it
                if (dist[u] != INF && dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }
    }

    long long minimumWeight(int n, std::vector<std::vector<int>>& edges, int source1, int source2, int dest) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        std::vector<std::vector<std::pair<int, int>>> rev_adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            rev_adj[v].push_back({u, w}); // For finding paths TO dest
        }

        std::vector<long long> dist_s1(n);
        std::vector<long long> dist_s2(n);
        std::vector<long long> dist_d(n); // This will store distances from dest in the reversed graph, effectively dist TO dest in original graph

        dijkstra(source1, n, adj, dist_s1);
        dijkstra(source2, n, adj, dist_s2);
        dijkstra(dest, n, rev_adj, dist_d); // Run Dijkstra on reversed graph from dest

        long long min_total_weight = INF;

        // Iterate through all possible meeting points 'i'
        for (int i = 0; i < n; ++i) {
            // If all three paths are reachable to/from node 'i'
            if (dist_s1[i] != INF && dist_s2[i] != INF && dist_d[i] != INF) {
                min_total_weight = std::min(min_total_weight, dist_s1[i] + dist_s2[i] + dist_d[i]);
            }
        }

        // If no valid path combination was found, min_total_weight remains INF
        return (min_total_weight == INF) ? -1 : min_total_weight;
    }
};