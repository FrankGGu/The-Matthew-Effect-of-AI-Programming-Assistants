#include <vector>
#include <queue>
#include <tuple>
#include <numeric>

class Solution {
public:
    int shortestPathLength(std::vector<std::vector<int>>& graph) {
        int n = graph.size();
        if (n == 1) {
            return 0;
        }

        std::queue<std::tuple<int, int, int>> q; // {node, mask, distance}
        std::vector<std::vector<int>> dist(n, std::vector<int>(1 << n, -1));

        // Initialize queue with all possible starting nodes
        for (int i = 0; i < n; ++i) {
            int initial_mask = (1 << i);
            q.push({i, initial_mask, 0});
            dist[i][initial_mask] = 0;
        }

        int all_nodes_visited_mask = (1 << n) - 1;

        while (!q.empty()) {
            auto [u, mask, d] = q.front();
            q.pop();

            if (mask == all_nodes_visited_mask) {
                return d;
            }

            for (int v : graph[u]) {
                int new_mask = mask | (1 << v);
                if (dist[v][new_mask] == -1) {
                    dist[v][new_mask] = d + 1;
                    q.push({v, new_mask, d + 1});
                }
            }
        }

        return -1; // Should not be reached as graph is connected
    }
};