#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int timeToMarkAllNodes(int n, std::vector<std::vector<int>>& edges, std::vector<int>& start_nodes) {
        if (n == 0) {
            return 0;
        }

        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> dist(n, -1);
        std::queue<int> q;

        for (int start_node : start_nodes) {
            if (start_node >= 0 && start_node < n) {
                if (dist[start_node] == -1) {
                    dist[start_node] = 0;
                    q.push(start_node);
                }
            }
        }

        int max_time = 0;
        int marked_count = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            marked_count++;
            max_time = std::max(max_time, dist[u]);

            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }

        if (marked_count < n) {
            return -1;
        }

        return max_time;
    }
};