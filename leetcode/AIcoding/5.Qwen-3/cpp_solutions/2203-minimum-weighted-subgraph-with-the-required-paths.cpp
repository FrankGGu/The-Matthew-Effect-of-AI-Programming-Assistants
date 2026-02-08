#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minWeightedSubgraph(int n, vector<vector<int>>& edges, vector<int>& srcs, vector<int>& dsts) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].push_back({v, w});
            graph[v].push_back({u, w});
        }

        auto dijkstra = [&](int start) -> vector<int> {
            vector<int> dist(n, INT_MAX);
            dist[start] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
            pq.push({0, start});
            while (!pq.empty()) {
                int d = pq.top().first;
                int u = pq.top().second;
                pq.pop();
                if (d > dist[u]) continue;
                for (auto& [v, w] : graph[u]) {
                    if (dist[v] > d + w) {
                        dist[v] = d + w;
                        pq.push({dist[v], v});
                    }
                }
            }
            return dist;
        };

        vector<int> srcDist(n, 0), dstDist(n, 0);
        for (int src : srcs) {
            vector<int> dist = dijkstra(src);
            for (int i = 0; i < n; ++i) {
                srcDist[i] += dist[i];
            }
        }

        for (int dst : dsts) {
            vector<int> dist = dijkstra(dst);
            for (int i = 0; i < n; ++i) {
                dstDist[i] += dist[i];
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            result = min(result, srcDist[i] + dstDist[i]);
        }

        return result;
    }
};