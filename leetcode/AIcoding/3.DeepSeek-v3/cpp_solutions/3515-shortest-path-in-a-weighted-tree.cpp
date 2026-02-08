#include <vector>
#include <queue>
#include <climits>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> minPathCost(vector<vector<int>>& edges, vector<int>& weight, int n, int k) {
        unordered_map<int, vector<pair<int, int>>> graph;
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].emplace_back(v, w);
            graph[v].emplace_back(u, w);
        }

        vector<int> dist(n, INT_MAX);
        dist[k] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, k);

        while (!pq.empty()) {
            auto [current_dist, u] = pq.top();
            pq.pop();

            if (current_dist > dist[u]) continue;

            for (const auto& [v, w] : graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.emplace(dist[v], v);
                }
            }
        }

        return dist;
    }
};