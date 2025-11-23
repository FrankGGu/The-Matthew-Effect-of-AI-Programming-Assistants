#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    int shortestPath(int n, std::vector<std::vector<int>>& edges, int start, int end) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        std::vector<int> dist(n, -1);
        std::queue<int> q;

        dist[start] = 0;
        q.push(start);

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (u == end) {
                return dist[u];
            }

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;
                if (dist[v] == -1) {
                    dist[v] = dist[u] + weight;
                    q.push(v);
                }
            }
        }

        return -1;
    }
};