#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    long long minimumWeight(int n, vector<vector<int>>& edges, int src1, int src2, int dest) {
        vector<vector<pair<int, int>>> adj(n);
        vector<vector<pair<int, int>>> revAdj(n);

        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            adj[u].push_back({v, w});
            revAdj[v].push_back({u, w});
        }

        auto dijkstra = [&](int start, vector<vector<pair<int, int>>>& graph) {
            vector<long long> dist(n, numeric_limits<long long>::max());
            dist[start] = 0;
            priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
            pq.push({0, start});

            while (!pq.empty()) {
                long long d = pq.top().first;
                int u = pq.top().second;
                pq.pop();

                if (d > dist[u]) continue;

                for (auto& edge : graph[u]) {
                    int v = edge.first;
                    int w = edge.second;
                    if (dist[u] != numeric_limits<long long>::max() && dist[v] > dist[u] + w) {
                        dist[v] = dist[u] + w;
                        pq.push({dist[v], v});
                    }
                }
            }
            return dist;
        };

        vector<long long> dist1 = dijkstra(src1, adj);
        vector<long long> dist2 = dijkstra(src2, adj);
        vector<long long> distDest = dijkstra(dest, revAdj);

        long long ans = numeric_limits<long long>::max();
        for (int i = 0; i < n; ++i) {
            if (dist1[i] != numeric_limits<long long>::max() &&
                dist2[i] != numeric_limits<long long>::max() &&
                distDest[i] != numeric_limits<long long>::max()) {
                ans = min(ans, dist1[i] + dist2[i] + distDest[i]);
            }
        }

        if (ans == numeric_limits<long long>::max()) return -1;
        return ans;
    }
};