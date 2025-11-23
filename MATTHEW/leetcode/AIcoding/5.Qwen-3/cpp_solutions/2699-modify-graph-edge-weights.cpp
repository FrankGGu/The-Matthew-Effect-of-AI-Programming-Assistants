#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<vector<int>> modifyEdgeWeights(int n, vector<vector<int>>& edges, int src, int dest, int target) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        auto dijkstra = [&](int start) -> vector<long long> {
            vector<long long> dist(n, LLONG_MAX);
            dist[start] = 0;
            priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<>> pq;
            pq.push({0, start});
            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (d > dist[u]) continue;
                for (auto [v, w] : graph[u]) {
                    if (dist[v] > d + w) {
                        dist[v] = d + w;
                        pq.push({dist[v], v});
                    }
                }
            }
            return dist;
        };

        vector<long long> initial_dist = dijkstra(src);
        if (initial_dist[dest] > target) return {};

        vector<vector<int>> result = edges;
        for (auto& e : result) {
            int u = e[0], v = e[1], w = e[2];
            if (initial_dist[u] + initial_dist[v] + w == target) {
                e[2] = target - initial_dist[u] - initial_dist[v];
            } else {
                e[2] = 1;
            }
        }

        return result;
    }
};