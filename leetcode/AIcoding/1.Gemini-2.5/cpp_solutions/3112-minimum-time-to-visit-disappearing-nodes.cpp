#include <vector>
#include <queue>
#include <utility>

class Solution {
public:
    std::vector<int> minimumTime(int n, std::vector<std::vector<int>>& edges, std::vector<int>& disappear) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        std::vector<int> dist(n, -1);
        dist[0] = 0;

        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            auto [time, u] = pq.top();
            pq.pop();

            if (time > dist[u]) {
                continue;
            }

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;
                int new_time = time + weight;

                if (v != 0 && new_time >= disappear[v]) {
                    continue;
                }

                if (dist[v] == -1 || new_time < dist[v]) {
                    dist[v] = new_time;
                    pq.push({new_time, v});
                }
            }
        }

        return dist;
    }
};