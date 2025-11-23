#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<long long> shortestDistanceAfterRoadAddition(int n, std::vector<std::vector<int>>& roads, std::vector<std::vector<int>>& queries) {
        // Define a large enough value for infinity.
        // Maximum path length N * max_weight = 400 * 10^9 = 4 * 10^11.
        // Sum of distances can be up to N*(N-1)/2 * max_path_length = 400*399/2 * 4*10^11 approx 3.2 * 10^16.
        // long long max is approx 9 * 10^18, so it fits.
        const long long INF = 4e11 + 7; 

        std::vector<std::vector<long long>> dist(n, std::vector<long long>(n, INF));

        // Initialize distances: 0 for self, INF for others
        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }

        // Add initial roads
        for (const auto& road : roads) {
            int u = road[0] - 1; // Adjust to 0-indexed
            int v = road[1] - 1; // Adjust to 0-indexed
            long long w = road[2];
            dist[u][v] = std::min(dist[u][v], w);
            dist[v][u] = std::min(dist[v][u], w);
        }

        // Run initial Floyd-Warshall to find all-pairs shortest paths
        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        std::vector<long long> results;
        for (const auto& query : queries) {
            int u_query = query[0] - 1; // Adjust to 0-indexed
            int v_query = query[1] - 1; // Adjust to 0-indexed
            long long w_query = query[2];

            // Update the direct edge (u_query, v_query) with the new road
            // This might shorten the existing shortest path between u_query and v_query
            dist[u_query][v_query] = std::min(dist[u_query][v_query], w_query);
            dist[v_query][u_query] = std::min(dist[v_query][u_query], w_query);

            // Propagate the effect of the new edge (u_query, v_query)
            // This is done by considering u_query and v_query as intermediate nodes
            // in the Floyd-Warshall algorithm.
            // The two loops below effectively apply one step of Floyd-Warshall
            // for k = u_query and k = v_query.
            // The order of these two loops (for u_query and v_query) does not matter.

            // Update paths passing through u_query
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][u_query] != INF && dist[u_query][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][u_query] + dist[u_query][j]);
                    }
                }
            }

            // Update paths passing through v_query
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][v_query] != INF && dist[v_query][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][v_query] + dist[v_query][j]);
                    }
                }
            }

            // Calculate the sum of all shortest distances for distinct pairs
            long long current_total_distance = 0;
            for (int i = 0; i < n; ++i) {
                for (int j = i + 1; j < n; ++j) { // Sum for distinct pairs (i, j) where i < j
                    if (dist[i][j] != INF) {
                        current_total_distance += dist[i][j];
                    }
                }
            }
            results.push_back(current_total_distance);
        }

        return results;
    }
};