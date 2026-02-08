#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    int minTrioDegree(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<bool>> adj(n + 1, std::vector<bool>(n + 1, false));
        std::vector<int> degree(n + 1, 0);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u]++;
            degree[v]++;
        }

        int min_trio_degree = std::numeric_limits<int>::max();

        for (int u = 1; u <= n; ++u) {
            for (int v = u + 1; v <= n; ++v) {
                if (adj[u][v]) {
                    for (int w = v + 1; w <= n; ++w) {
                        if (adj[v][w] && adj[w][u]) {
                            int current_trio_degree = (degree[u] - 2) + (degree[v] - 2) + (degree[w] - 2);
                            min_trio_degree = std::min(min_trio_degree, current_trio_degree);
                        }
                    }
                }
            }
        }

        if (min_trio_degree == std::numeric_limits<int>::max()) {
            return -1;
        } else {
            return min_trio_degree;
        }
    }
};