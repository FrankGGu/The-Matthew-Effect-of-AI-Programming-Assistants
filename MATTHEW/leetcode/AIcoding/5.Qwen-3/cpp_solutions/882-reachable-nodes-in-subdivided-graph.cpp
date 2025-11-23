#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int reachableNodes(vector<vector<int>>& edges, int maxMoves, int n) {
        unordered_map<int, vector<pair<int, int>>> graph;
        for (auto& e : edges) {
            graph[e[0]].push_back({e[1], e[2]});
            graph[e[1]].push_back({e[0], e[2]});
        }

        vector<int> dist(n, -1);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        dist[0] = 0;
        pq.push({0, 0});

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (d > dist[u]) continue;
            for (auto [v, w] : graph[u]) {
                if (dist[v] == -1 || d + w < dist[v]) {
                    dist[v] = d + w;
                    pq.push({dist[v], v});
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (dist[i] <= maxMoves) {
                ++result;
            }
        }

        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            int a = dist[u] == -1 ? 0 : max(0, maxMoves - dist[u]);
            int b = dist[v] == -1 ? 0 : max(0, maxMoves - dist[v]);
            result += min(a + b, w);
        }

        return result;
    }
};