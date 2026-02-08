#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
private:
    int N;
    std::vector<std::vector<long long>> dist;
    // Use a large enough value for infinity, but not LLONG_MAX to avoid overflow when adding two distances.
    long long INF = std::numeric_limits<long long>::max() / 2;

public:
    std::vector<long long> shortestDistanceAfterRoadAdditionQueries(int n, std::vector<std::vector<int>>& initial_edges, std::vector<std::vector<int>>& queries) {
        N = n;
        dist.assign(N, std::vector<long long>(N, INF));

        for (int i = 0; i < N; ++i) {
            dist[i][i] = 0;
        }

        for (const auto& edge : initial_edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            dist[u][v] = std::min(dist[u][v], (long long)w);
            dist[v][u] = std::min(dist[v][u], (long long)w); // Assuming undirected graph
        }

        // Initial Floyd-Warshall to compute all-pairs shortest paths for the initial graph
        for (int k = 0; k < N; ++k) {
            for (int i = 0; i < N; ++i) {
                for (int j = 0; j < N; ++j) {
                    // Check for INF to prevent overflow and ensure path validity
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        std::vector<long long> results;
        for (const auto& road_query : queries) {
            int u = road_query[0];
            int v = road_query[1];
            int w = road_query[2];

            // Optimization: only update if the new road provides a strictly shorter path between u and v.
            // If w is not strictly shorter than the current shortest path dist[u][v],
            // then adding this road won't improve any existing shortest path.
            // This also handles cases where dist[u][v] was INF, as w (finite) < INF will be true.
            if ((long long)w < dist[u][v]) {
                // Update the direct edge weight to w
                dist[u][v] = (long long)w;
                dist[v][u] = (long long)w; // Assuming undirected graph

                // Perform O(N^2) update for all pairs.
                // For every pair (i, j), check if a path passing through the new edge (u,v) or (v,u) is shorter.
                for (int i = 0; i < N; ++i) {
                    for (int j = 0; j < N; ++j) {
                        // Path i -> u -> v -> j
                        // Check for INF to prevent overflow and ensure path validity
                        if (dist[i][u] != INF && dist[v][j] != INF) {
                            dist[i][j] = std::min(dist[i][j], dist[i][u] + dist[u][v] + dist[v][j]);
                        }
                        // Path i -> v -> u -> j
                        // Check for INF to prevent overflow and ensure path validity
                        if (dist[i][v] != INF && dist[u][j] != INF) {
                            dist[i][j] = std::min(dist[i][j], dist[i][v] + dist[v][u] + dist[u][j]);
                        }
                    }
                }
            }

            // Calculate the sum of shortest distances for unique pairs (i, j) where i < j
            long long current_total_dist = 0;
            for (int i = 0; i < N; ++i) {
                for (int j = i + 1; j < N; ++j) { // Iterate for unique pairs (i, j)
                    if (dist[i][j] != INF) { // Only sum reachable pairs
                        current_total_dist += dist[i][j];
                    }
                }
            }
            results.push_back(current_total_dist);
        }
        return results;
    }
};