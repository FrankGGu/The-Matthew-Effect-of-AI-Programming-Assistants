#include <vector>
#include <queue>
#include <limits>
#include <utility>

class Solution {
public:
    int networkDelayTime(std::vector<std::vector<int>>& times, int n, int k) {
        std::vector<std::vector<std::pair<int, int>>> adj(n + 1);
        for (const auto& time : times) {
            int u = time[0];
            int v = time[1];
            int w = time[2];
            adj[u].push_back({v, w});
        }

        std::vector<int> dist(n + 1, std::numeric_limits<int>::max());
        dist[k] = 0;

        // Min-priority queue: stores pairs of (time, node)
        std::priority_queue<std::pair<int, int>, std::vector<std::pair<int, int>>, std::greater<std::pair<int, int>>> pq;
        pq.push({0, k});

        while (!pq.empty()) {
            int current_time = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (current_time > dist[u]) {
                continue;
            }

            for (const auto& edge : adj[u]) {
                int v = edge.first;
                int travel_time = edge.second;

                if (dist[u] + travel_time < dist[v]) {
                    dist[v] = dist[u] + travel_time;
                    pq.push({dist[v], v});
                }
            }
        }

        int max_delay = 0;
        for (int i = 1; i <= n; ++i) {
            if (dist[i] == std::numeric_limits<int>::max()) {
                return -1; // Not all nodes are reachable
            }
            if (dist[i] > max_delay) {
                max_delay = dist[i];
            }
        }

        return max_delay;
    }
};