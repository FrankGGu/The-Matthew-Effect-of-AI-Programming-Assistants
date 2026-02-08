#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int findTheCity(int n, vector<vector<int>>& edges, int distanceThreshold) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        int minReachable = INT_MAX;
        int city = -1;

        for (int startNode = 0; startNode < n; ++startNode) {
            vector<int> dist(n, INT_MAX);
            dist[startNode] = 0;
            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            pq.push({0, startNode});

            while (!pq.empty()) {
                int d = pq.top().first;
                int u = pq.top().second;
                pq.pop();

                if (d > dist[u]) continue;

                for (auto& neighbor : adj[u]) {
                    int v = neighbor.first;
                    int weight = neighbor.second;

                    if (dist[v] > dist[u] + weight) {
                        dist[v] = dist[u] + weight;
                        pq.push({dist[v], v});
                    }
                }
            }

            int reachableCount = 0;
            for (int i = 0; i < n; ++i) {
                if (dist[i] <= distanceThreshold) {
                    reachableCount++;
                }
            }

            if (reachableCount <= minReachable) {
                minReachable = reachableCount;
                city = startNode;
            }
        }

        return city;
    }
};