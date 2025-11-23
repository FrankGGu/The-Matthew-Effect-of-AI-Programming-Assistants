#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> color; // -1: uncolored, 0: color A, 1: color B
    std::vector<bool> visited; // Tracks nodes visited across all components

    // Performs a BFS to find the farthest node from start_node within its component,
    // and simultaneously checks if the component is bipartite.
    // Returns {farthest_node, max_distance} if bipartite, or {-1, -1} if not.
    std::pair<int, int> bfs_bipartite_check(int start_node, int n_nodes, bool& is_bipartite_component) {
        std::queue<int> q;
        q.push(start_node);
        color[start_node] = 0;
        visited[start_node] = true;

        int farthest_node = start_node;
        int max_dist = 0;

        std::vector<int> dist(n_nodes, -1); // Distance from start_node for this BFS
        dist[start_node] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (dist[u] > max_dist) {
                max_dist = dist[u];
                farthest_node = u;
            }

            for (int v : adj[u]) {
                if (color[v] == -1) { // Unvisited in this component
                    color[v] = 1 - color[u];
                    visited[v] = true;
                    dist[v] = dist[u] + 1;
                    q.push(v);
                } else if (color[v] == color[u]) { // Conflict, not bipartite
                    is_bipartite_component = false;
                    return {-1, -1}; // Indicate failure
                }
            }
        }
        return {farthest_node, max_dist};
    }

    // Performs a BFS from start_node to find the maximum distance to any node
    // within its connected component. Assumes the component is already identified
    // and nodes are marked `visited`.
    int bfs_get_max_dist(int start_node, int n_nodes) {
        std::queue<int> q;
        q.push(start_node);

        std::vector<int> dist(n_nodes, -1);
        dist[start_node] = 0;
        int max_d = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            max_d = std::max(max_d, dist[u]);

            for (int v : adj[u]) {
                // `visited[v]` is implicitly true because `v` is adjacent to `u`
                // and `u` is part of the current component which has been traversed
                // by the initial `bfs_bipartite_check`.
                // We just need to check `dist[v] == -1` to ensure `v` hasn't been
                // visited in *this specific* BFS yet.
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }
        return max_d;
    }

    int divideNodesIntoTheMaximumNumberOfGroups(int n, std::vector<std::vector<int>>& edges) {
        adj.resize(n);
        color.assign(n, -1); // Initialize all nodes as uncolored
        visited.assign(n, false); // Initialize all nodes as unvisited

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int total_max_groups = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) { // If node i belongs to a new, unvisited component
                bool is_bipartite_component = true;
                std::pair<int, int> bfs1_result = bfs_bipartite_check(i, n, is_bipartite_component);

                if (!is_bipartite_component) {
                    return 0; // Graph is not bipartite, impossible to satisfy conditions
                }

                // If bipartite, find the diameter of this component using a second BFS
                int farthest_node_1 = bfs1_result.first;
                int component_diameter = bfs_get_max_dist(farthest_node_1, n);

                // The maximum number of groups for this component is its diameter + 1
                total_max_groups += (component_diameter + 1);
            }
        }

        return total_max_groups;
    }
};