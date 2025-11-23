#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    vector<long long> minCost(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        vector<long long> result;
        for (auto& query : queries) {
            int start = query[0];
            int end = query[1];

            vector<long long> dist(n + 1, numeric_limits<long long>::max());
            dist[start] = 0;
            priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
            pq.push({0, start});

            while (!pq.empty()) {
                long long d = pq.top().first;
                int u = pq.top().second;
                pq.pop();

                if (d > dist[u]) continue;

                for (auto& edge : adj[u]) {
                    int v = edge.first;
                    int weight = edge.second;
                    if (dist[v] > dist[u] + weight) {
                        dist[v] = dist[u] + weight;
                        pq.push({dist[v], v});
                    }
                }
            }

            if (dist[end] == numeric_limits<long long>::max()) {
                result.push_back(-1);
            } else {
                result.push_back(dist[end]);
            }
        }

        return result;
    }
};