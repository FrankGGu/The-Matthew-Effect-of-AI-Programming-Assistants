#include <vector>
#include <queue>
#include <limits> // Required for std::numeric_limits
#include <utility> // Required for std::pair

class Solution {
public:
    int shortestPath(int n, std::vector<std::vector<int>>& edges, int start_node, int end_node) {
        // Adjacency list to represent the graph: adj[u] stores pairs {v, weight}
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];
            adj[u].push_back({v, weight});
            // If the graph is undirected, uncomment the following line:
            // adj[v].push_back({u, weight});
        }

        // Distance array, initialized to a very large value (infinity)
        // Using long long to prevent potential overflow for large path sums
        std::vector<long long> dist(n, std::numeric_limits<long long>::max());
        dist[start_node] = 0;

        // Priority queue to store {distance, node} pairs.
        // It's a min-heap, so the element with the smallest distance is at the top.
        std::priority_queue<std::pair<long long, int>,
                            std::vector<std::pair<long long, int>>,
                            std::greater<std::pair<long long, int>>> pq;
        pq.push({0, start_node});

        while (!pq.empty()) {
            long long d = pq.top().first; // Current shortest distance to 'u'
            int u = pq.top().second;     // Current node
            pq.pop();

            // If we found a shorter path to 'u' previously, skip this stale entry
            if (d > dist[u]) {
                continue;
            }

            // If we reached the destination node, we can return its distance
            if (u == end_node) {
                return static_cast<int>(d);
            }

            // Explore neighbors of 'u'
            for (const auto& edge : adj[u]) {
                int v = edge.first;     // Neighbor node
                int weight = edge.second; // Weight of the edge (u, v)

                // If a shorter path to 'v' is found through 'u'
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight; // Update distance to 'v'
                    pq.push({dist[v], v});      // Add 'v' to the priority queue
                }
            }
        }

        // If the end_node is unreachable, its distance will still be infinity
        if (dist[end_node] == std::numeric_limits<long long>::max()) {
            return -1; // Return -1 to indicate unreachability
        } else {
            return static_cast<int>(dist[end_node]); // Return the shortest distance
        }
    }
};