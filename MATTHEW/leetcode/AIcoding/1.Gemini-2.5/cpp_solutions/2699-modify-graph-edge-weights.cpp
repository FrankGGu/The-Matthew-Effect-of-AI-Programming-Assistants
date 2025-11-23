#include <vector>
#include <queue>
#include <tuple>
#include <limits>
#include <algorithm>

using namespace std;

const long long INF = numeric_limits<long long>::max();

vector<long long> dijkstra(int start_node, int num_nodes, const vector<vector<int>>& current_edges) {
    vector<vector<pair<int, int>>> adj(num_nodes);
    for (const auto& edge : current_edges) {
        int u = edge[0];
        int v = edge[1];
        int w = edge[2];
        int effective_w = (w == -1) ? 1 : w; // Treat -1 as 1 for shortest path calculation
        adj[u].push_back({v, effective_w});
        adj[v].push_back({u, effective_w});
    }

    vector<long long> dist(num_nodes, INF);
    dist[start_node] = 0;
    priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
    pq.push({0, start_node});

    while (!pq.empty()) {
        long long d = pq.top().first;
        int u = pq.top().second;
        pq.pop();

        if (d > dist[u]) {
            continue;
        }

        for (const auto& edge_info : adj[u]) {
            int v = edge_info.first;
            int weight = edge_info.second;
            if (dist[u] != INF && dist[u] + weight < dist[v]) {
                dist[v] = dist[u] + weight;
                pq.push({dist[v], v});
            }
        }
    }
    return dist;
}

class Solution {
public:
    vector<vector<int>> modifiedGraphEdges(int n, vector<vector<int>>& edges, int source, int destination, int target) {
        vector<vector<int>> result_edges = edges; // Copy of edges to modify

        // Step 1: Calculate shortest path with all -1 edges set to 1.
        // This gives the minimum possible shortest path length.
        vector<long long> dist_from_source = dijkstra(source, n, result_edges);
        long long current_min_path_len = dist_from_source[destination];

        // Step 2: Handle cases based on current_min_path_len vs target
        if (current_min_path_len < target) {
            // Case 1: Minimum possible shortest path is less than target.
            // We need to increase the path length by `diff_to_add`.
            long long diff_to_add = target - current_min_path_len;

            // Calculate shortest paths from all nodes to destination, treating -1 edges as 1.
            // This is equivalent to running Dijkstra from destination on the original graph (since it's undirected).
            vector<long long> dist_to_destination = dijkstra(destination, n, result_edges);

            bool diff_spent = false; // Flag to track if the `diff_to_add` budget has been fully spent

            for (int i = 0; i < result_edges.size(); ++i) {
                int u = result_edges[i][0];
                int v = result_edges[i][1];
                int w = result_edges[i][2];

                if (w == -1) {
                    if (!diff_spent) {
                        // Consider this -1 edge (u, v).
                        // If it's part of a path from source to destination, its contribution to the path length
                        // would be `dist_from_source[u] + weight_of_uv + dist_to_destination[v]`.
                        // We want this total path length to be `target`.
                        // So, `weight_of_uv = target - dist_from_source[u] - dist_to_destination[v]`.
                        // We also need `weight_of_uv >= 1`.

                        // Check if paths to u and from v are even possible
                        if (dist_from_source[u] != INF && dist_to_destination[v] != INF) {
                            long long needed_weight_for_target = target - dist_from_source[u] - dist_to_destination[v];

                            if (needed_weight_for_target >= 1) {
                                // Calculate how much we need to increase this edge's weight (from 1)
                                // to make the path through it exactly `target`.
                                // current path length through this edge (if it's 1) = dist_from_source[u] + 1 + dist_to_destination[v]
                                // increase_needed = target - (dist_from_source[u] + 1 + dist_to_destination[v])
                                long long increase_needed_for_this_edge = target - dist_from_source[u] - dist_to_destination[v] - 1;

                                if (increase_needed_for_this_edge >= 0) { // Can increase weight
                                    long long actual_increase = min(diff_to_add, increase_needed_for_this_edge);
                                    result_edges[i][2] = 1 + actual_increase;
                                    diff_to_add -= actual_increase;
                                } else { // Even with weight 1, path through this edge is already >= target.
                                    result_edges[i][2] = 1;
                                }
                            } else { // needed_weight_for_target < 1, means even with weight 1, path through this edge is >= target
                                result_edges[i][2] = 1;
                            }
                        } else { // No path from source to u or from v to destination
                            result_edges[i][2] = 1;
                        }

                        if (diff_to_add == 0) {
                            diff_spent = true; // All budget for increasing path length has been spent
                        }
                    } else { // `diff_to_add` budget already spent, assign minimum possible weight
                        result_edges[i][2] = 1;
                    }
                }
            }

            // After assigning weights to all -1 edges, verify the shortest path is exactly target.
            // This is crucial because modifying one edge might change the overall shortest path.
            vector<long long> final_dist = dijkstra(source, n, result_edges);
            if (final_dist[destination] == target) {
                return result_edges;
            } else {
                // This case indicates that even after distributing the `diff_to_add`,
                // the shortest path is not exactly `target`. This could happen if
                // the `diff_to_add` was not enough or was distributed suboptimally for a different path.
                // However, the greedy distribution strategy should work for "any solution".
                return {}; 
            }

        } else if (current_min_path_len > target) {
            // Case 2: Minimum possible shortest path (all -1s as 1) is already greater than target.
            // It's impossible to achieve the target, as we can only increase weights.
            return {};

        } else { // current_min_path_len == target
            // Case 3: Minimum possible shortest path (all -1s as 1) is exactly target.
            // We can achieve the target by setting all -1 edges to 1.
            for (auto& edge : result_edges) {
                if (edge[2] == -1) {
                    edge[2] = 1;
                }
            }
            return result_edges;
        }
    }
};