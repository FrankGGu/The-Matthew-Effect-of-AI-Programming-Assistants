#include <vector>
#include <queue>
#include <utility>
#include <climits>

class Solution {
public:
    int countPaths(int n, std::vector<std::vector<int>>& roads) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& road : roads) {
            adj[road[0]].push_back({road[1], road[2]});
            adj[road[1]].push_back({road[0], road[2]});
        }

        int mod = 1e9 + 7;
        std::vector<long long> dist(n, LLONG_MAX);
        std::vector<int> ways(n, 0);

        std::priority_queue<std::pair<long long, int>, std::vector<std::pair<long long, int>>, std::greater<std::pair<long long, int>>> pq;

        dist[0] = 0;
        ways[0] = 1;
        pq.push({0, 0});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) {
                continue;
            }

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;

                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    ways[v] = ways[u];
                    pq.push({dist[v], v});
                } else if (dist[u] + weight == dist[v]) {
                    ways[v] = (static_cast<long long>(ways[v]) + ways[u]) % mod;
                }
            }
        }

        return ways[n - 1];
    }
};