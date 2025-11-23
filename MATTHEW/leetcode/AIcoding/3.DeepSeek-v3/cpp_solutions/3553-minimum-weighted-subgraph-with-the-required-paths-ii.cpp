#include <vector>
#include <queue>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumWeight(int n, vector<vector<int>>& edges, int src1, int src2, int dest) {
        vector<vector<pair<int, int>>> adj(n), rev_adj(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            adj[u].emplace_back(v, w);
            rev_adj[v].emplace_back(u, w);
        }

        auto dijkstra = [&](int src, vector<vector<pair<int, int>>>& graph) {
            vector<long long> dist(n, LLONG_MAX);
            dist[src] = 0;
            priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
            pq.emplace(0, src);
            while (!pq.empty()) {
                auto [d, u] = pq.top();
                pq.pop();
                if (d > dist[u]) continue;
                for (auto [v, w] : graph[u]) {
                    if (dist[v] > dist[u] + w) {
                        dist[v] = dist[u] + w;
                        pq.emplace(dist[v], v);
                    }
                }
            }
            return dist;
        };

        vector<long long> dist1 = dijkstra(src1, adj);
        vector<long long> dist2 = dijkstra(src2, adj);
        vector<long long> dist_dest = dijkstra(dest, rev_adj);

        long long res = LLONG_MAX;
        for (int i = 0; i < n; ++i) {
            if (dist1[i] != LLONG_MAX && dist2[i] != LLONG_MAX && dist_dest[i] != LLONG_MAX) {
                res = min(res, dist1[i] + dist2[i] + dist_dest[i]);
            }
        }

        return res == LLONG_MAX ? -1 : res;
    }
};