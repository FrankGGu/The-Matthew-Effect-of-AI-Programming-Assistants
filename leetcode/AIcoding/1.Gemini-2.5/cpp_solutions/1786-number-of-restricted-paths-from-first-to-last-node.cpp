#include <vector>
#include <queue>
#include <limits>
#include <functional>

class Solution {
public:
    int countRestrictedPaths(int n, std::vector<std::vector<int>>& edges) {
        // Part 1: Calculate shortest distances from all nodes to node n using Dijkstra's algorithm.
        // The graph is treated as undirected for this step to find shortest paths to 'n' from all other nodes.
        std::vector<std::vector<std::pair<int, int>>> adj(n + 1);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            adj[v].push_back({u, w});
        }

        std::vector<long long> dist(n + 1, std::numeric_limits<long long>::max());
        // Min-priority queue stores pairs of {distance, node}.
        // We use std::greater to make it a min-priority queue.
        std::priority_queue<std::pair<long long, int>, 
                            std::vector<std::pair<long long, int>>, 
                            std::greater<std::pair<long long, int>>> pq;

        dist[n] = 0; // Shortest distance from n to n is 0.
        pq.push({0, n});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            // If we found a shorter path to 'u' already, skip this one.
            if (d > dist[u]) {
                continue;
            }

            // Explore neighbors of 'u'.
            for (const auto& edge_pair : adj[u]) {
                int v = edge_pair.first;
                int weight = edge_pair.second;
                // If a shorter path to 'v' is found through 'u'.
                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }

        // Part 2: Count restricted paths using Dynamic Programming with Memoization (DFS).
        // A path is restricted if for any two consecutive nodes u and v in the path, dist[u] > dist[v].
        // This condition implies a directed acyclic graph (DAG) where edges only go from
        // nodes with larger shortest distances to 'n' to nodes with smaller shortest distances to 'n'.

        std::vector<int> memo(n + 1, -1); // Memoization table, -1 indicates not computed.
        const int MOD = 1e9 + 7;

        // Lambda function for DFS with memoization.
        // It calculates the number of restricted paths from node 'u' to node 'n'.
        std::function<int(int)> dfs = [&](int u) {
            if (u == n) {
                return 1; // Base case: There is one path from node n to itself.
            }
            if (memo[u] != -1) {
                return memo[u]; // Return memoized result if already computed.
            }

            long long current_paths = 0;
            // Iterate over neighbors of 'u'.
            for (const auto& edge_pair : adj[u]) {
                int v = edge_pair.first;
                // Check the restricted path condition: dist[u] > dist[v].
                if (dist[u] > dist[v]) {
                    // If condition met, add the number of restricted paths from 'v' to 'n'.
                    current_paths = (current_paths + dfs(v)) % MOD;
                }
            }
            return memo[u] = current_paths; // Store and return the computed result.
        };

        // The problem asks for the number of restricted paths from node 1 to node n.
        return dfs(1);
    }
};