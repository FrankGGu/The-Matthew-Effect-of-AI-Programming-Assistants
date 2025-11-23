#include <vector>
#include <cmath>
#include <limits>
#include <algorithm>

class Solution {
public:
    int minCostConnectPoints(std::vector<std::vector<int>>& points) {
        int n = points.size();
        if (n <= 1) {
            return 0;
        }

        std::vector<int> min_dist(n, std::numeric_limits<int>::max());
        std::vector<bool> in_mst(n, false);

        min_dist[0] = 0; 

        int total_cost = 0;
        int edges_count = 0;

        while (edges_count < n) {
            int u = -1;
            int current_min_edge = std::numeric_limits<int>::max();

            for (int i = 0; i < n; ++i) {
                if (!in_mst[i] && min_dist[i] < current_min_edge) {
                    current_min_edge = min_dist[i];
                    u = i;
                }
            }

            if (u == -1) { 
                break;
            }

            in_mst[u] = true;
            total_cost += current_min_edge;
            edges_count++;

            for (int v = 0; v < n; ++v) {
                if (!in_mst[v]) {
                    int distance = std::abs(points[u][0] - points[v][0]) + std::abs(points[u][1] - points[v][1]);
                    if (distance < min_dist[v]) {
                        min_dist[v] = distance;
                    }
                }
            }
        }

        return total_cost;
    }
};