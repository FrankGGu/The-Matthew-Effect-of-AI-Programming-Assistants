#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int findTheCity(int n, std::vector<std::vector<int>>& edges, int threshold) {
        const int INF = std::numeric_limits<int>::max();
        std::vector<std::vector<int>> dist(n, std::vector<int>(n, INF));

        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            dist[u][v] = std::min(dist[u][v], w);
            dist[v][u] = std::min(dist[v][u], w);
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        dist[i][j] = std::min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        int min_reachable_count = n + 1;
        int result_city = -1;

        for (int i = 0; i < n; ++i) {
            int current_reachable_count = 0;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                if (dist[i][j] <= threshold) {
                    current_reachable_count++;
                }
            }

            if (current_reachable_count <= min_reachable_count) {
                min_reachable_count = current_reachable_count;
                result_city = i;
            }
        }

        return result_city;
    }
};