#include <vector>
#include <queue>
#include <limits> // For std::numeric_limits

class Solution {
public:
    std::vector<bool> findEdgesInShortestPaths(int n, std::vector<std::vector<int>>& edges) {
        // Adjacency list for the graph
        std::vector<std::vector<std::pair<int, int>>> adj(n);

        // Build adjacency list for an undirected graph
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            adj[v].push_back({u, w});
        }

        // Dijkstra function to find shortest distances from a start_node
        auto dijkstra = [&](int start_node, const std::vector<std::vector<std::pair<int, int>>>& graph) {
            std::vector<long long> dist(n, std::numeric_limits<long long>::max());
            // Priority queue stores pairs of (distance, node)
            std::priority_queue<std::pair<long long, int>, 
                                std::vector<std::pair<long long, int>>, 
                                std::greater<std::pair<long long, int>>> pq;

            dist[start_node] = 0;
            pq.push({0, start_node});

            while (!pq.empty()) {
                long long d = pq.top().first;
                int u = pq.top().second;
                pq.pop();

                // If we found a shorter path to u already, skip
                if (d > dist[u]) {
                    continue;
                }

                // Iterate over neighbors of u
                for (const auto& edge_pair : graph[u]) {
                    int v = edge_pair.first;
                    int weight = edge_pair.second;

                    // Check for overflow before addition and update distance
                    if (dist[u] != std::numeric_limits<long long>::max() && dist[u] + weight < dist[v]) {
                        dist[v] = dist[u] + weight;
                        pq.push({dist[v], v});
                    }
                }
            }
            return dist;
        };

        // Run Dijkstra from source (node 0) to get shortest distances to all nodes
        std::vector<long long> dist_from_src = dijkstra(0, adj);

        // Run Dijkstra from target (node n-1) to get shortest distances from all nodes to n-1.
        // In an undirected graph, shortest path from X to Y is same as Y to X.
        // So, dijkstra(n-1, adj) computes shortest distances from n-1 to all other nodes.
        // dist_from_target[i] will store shortest path from n-1 to i (which is shortest path from i to n-1).
        std::vector<long long> dist_from_target = dijkstra(n - 1, adj);

        // The total shortest path length from 0 to n-1
        long long shortest_path_len = dist_from_src[n - 1];

        // Initialize result array
        std::vector<bool> result(edges.size(), false);

        // Check each original edge
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];

            // An edge (u, v) with weight w is part of a shortest path from 0 to n-1 if:
            // (shortest path from 0 to u) + w + (shortest path from v to n-1) == (total shortest path from 0 to n-1)
            if (dist_from_src[u] != std::numeric_limits<long long>::max() &&
                dist_from_target[v] != std::numeric_limits<long long>::max() &&
                dist_from_src[u] + w + dist_from_target[v] == shortest_path_len) {
                result[i] = true;
            }

            // For undirected graphs, also check the path through v -> u
            // (shortest path from 0 to v) + w + (shortest path from u to n-1) == (total shortest path from 0 to n-1)
            if (dist_from_src[v] != std::numeric_limits<long long>::max() &&
                dist_from_target[u] != std::numeric_limits<long long>::max() &&
                dist_from_src[v] + w + dist_from_target[u] == shortest_path_len) {
                result[i] = true;
            }
        }

        return result;
    }
};