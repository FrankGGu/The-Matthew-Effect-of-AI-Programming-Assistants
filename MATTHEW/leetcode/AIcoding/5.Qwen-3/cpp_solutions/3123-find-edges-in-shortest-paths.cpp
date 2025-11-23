#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<vector<int>> findEdgesInShortestPaths(int n, vector<vector<int>>& edges, int source, int target) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        vector<int> dist(n, INT_MAX);
        dist[source] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, source});

        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) continue;

            for (const auto& [v, w] : graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.push({dist[v], v});
                }
            }
        }

        vector<vector<int>> result;
        vector<bool> inShortestPath(n, false);
        inShortestPath[target] = true;

        for (int i = 0; i < n; ++i) {
            for (const auto& [v, w] : graph[i]) {
                if (dist[i] + w == dist[v] && inShortestPath[v]) {
                    inShortestPath[i] = true;
                }
            }
        }

        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            if (inShortestPath[u] && inShortestPath[v]) {
                result.push_back({u, v, w});
            }
        }

        return result;
    }
};