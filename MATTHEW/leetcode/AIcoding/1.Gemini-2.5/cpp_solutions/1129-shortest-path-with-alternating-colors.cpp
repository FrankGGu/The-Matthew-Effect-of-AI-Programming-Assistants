#include <vector>
#include <queue>
#include <algorithm>
#include <limits>

class Solution {
public:
    std::vector<int> shortestAlternatingPaths(int n, std::vector<std::vector<int>>& red_edges, std::vector<std::vector<int>>& blue_edges) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : red_edges) {
            adj[edge[0]].push_back({edge[1], 0}); // 0 for red
        }
        for (const auto& edge : blue_edges) {
            adj[edge[0]].push_back({edge[1], 1}); // 1 for blue
        }

        std::vector<std::vector<int>> dist(n, std::vector<int>(2, std::numeric_limits<int>::max()));
        std::queue<std::pair<int, int>> q;

        dist[0][0] = 0;
        dist[0][1] = 0;
        q.push({0, 0}); // Node 0, arrived via a dummy red edge (to allow next edge to be blue)
        q.push({0, 1}); // Node 0, arrived via a dummy blue edge (to allow next edge to be red)

        while (!q.empty()) {
            std::pair<int, int> current = q.front();
            q.pop();
            int u = current.first;
            int prev_color = current.second;

            int next_color = 1 - prev_color;

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int edge_color = edge.second;

                if (edge_color == next_color) {
                    if (dist[v][edge_color] == std::numeric_limits<int>::max()) {
                        dist[v][edge_color] = dist[u][prev_color] + 1;
                        q.push({v, edge_color});
                    }
                }
            }
        }

        std::vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            int min_path = std::min(dist[i][0], dist[i][1]);
            result[i] = (min_path == std::numeric_limits<int>::max()) ? -1 : min_path;
        }

        return result;
    }
};