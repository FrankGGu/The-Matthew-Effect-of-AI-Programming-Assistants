#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxKWeightedPath(int n, vector<vector<int>>& edges, int k) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].emplace_back(v, w);
            graph[v].emplace_back(u, w);
        }

        vector<int> dist(n, -1);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.emplace(0, 0);
        dist[0] = 0;

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (u == n - 1) break;
            for (auto [v, w] : graph[u]) {
                if (dist[v] < d + w) {
                    dist[v] = d + w;
                    pq.emplace(dist[v], v);
                }
            }
        }

        return dist[n - 1];
    }
};