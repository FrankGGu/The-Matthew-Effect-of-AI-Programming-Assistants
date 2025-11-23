#include <iostream>
#include <vector>
#include <queue>
#include <climits>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minWeightedSubgraphWithRequiredPaths(vector<vector<int>>& edges, vector<vector<int>>& requiredPaths, int n) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            adj[u].push_back({v, w});
            adj[v].push_back({u, w});
        }

        vector<int> dist(n, INT_MAX);
        auto dijkstra = [&](int start) {
            dist.assign(n, INT_MAX);
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
            dist[start] = 0;
            pq.push({0, start});
            while (!pq.empty()) {
                int d = pq.top().first;
                int u = pq.top().second;
                pq.pop();
                if (d > dist[u]) continue;
                for (auto& [v, w] : adj[u]) {
                    if (dist[v] > dist[u] + w) {
                        dist[v] = dist[u] + w;
                        pq.push({dist[v], v});
                    }
                }
            }
            return dist;
        };

        unordered_map<int, int> pathCount;
        for (auto& path : requiredPaths) {
            for (int node : path) {
                pathCount[node]++;
            }
        }

        vector<int> totalDist(n, 0);
        for (auto& [node, count] : pathCount) {
            vector<int> dist = dijkstra(node);
            for (int i = 0; i < n; ++i) {
                totalDist[i] += dist[i];
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (pathCount.find(i) != pathCount.end()) {
                result = min(result, totalDist[i]);
            }
        }

        return result;
    }
};