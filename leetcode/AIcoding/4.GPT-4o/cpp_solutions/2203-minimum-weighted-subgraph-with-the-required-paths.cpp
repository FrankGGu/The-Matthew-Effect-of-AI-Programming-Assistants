#include <vector>
#include <queue>
#include <tuple>
#include <limits>

using namespace std;

class Solution {
public:
    int minimumWeight(int n, vector<vector<int>>& edges, int src1, int src2, int dest) {
        vector<vector<pair<int, int>>> graph(n), reverseGraph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            reverseGraph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        auto dijkstra = [&](int start, const vector<vector<pair<int, int>>>& g) {
            vector<int> dist(n, numeric_limits<int>::max());
            dist[start] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            pq.emplace(0, start);

            while (!pq.empty()) {
                auto [d, u] = pq.top(); pq.pop();
                if (d > dist[u]) continue;

                for (const auto& [v, w] : g[u]) {
                    if (dist[u] + w < dist[v]) {
                        dist[v] = dist[u] + w;
                        pq.emplace(dist[v], v);
                    }
                }
            }
            return dist;
        };

        vector<int> distFromSrc1 = dijkstra(src1, graph);
        vector<int> distFromSrc2 = dijkstra(src2, graph);
        vector<int> distToDest = dijkstra(dest, reverseGraph);

        int minWeight = numeric_limits<int>::max();
        for (int i = 0; i < n; ++i) {
            if (distFromSrc1[i] != numeric_limits<int>::max() && distFromSrc2[i] != numeric_limits<int>::max() && distToDest[i] != numeric_limits<int>::max()) {
                minWeight = min(minWeight, distFromSrc1[i] + distFromSrc2[i] + distToDest[i]);
            }
        }

        return minWeight == numeric_limits<int>::max() ? -1 : minWeight;
    }
};