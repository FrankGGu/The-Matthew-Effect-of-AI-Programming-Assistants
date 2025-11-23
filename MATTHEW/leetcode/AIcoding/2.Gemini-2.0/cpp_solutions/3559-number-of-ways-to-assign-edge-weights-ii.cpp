#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countPaths(int n, vector<vector<int>>& edges) {
        long long mod = 1e9 + 7;
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        vector<long long> zeroPaths(n + 1, 0);
        vector<long long> onePaths(n + 1, 0);
        vector<long long> dist(n + 1, -1);

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        pq.push({0, 1});
        dist[1] = 0;
        zeroPaths[1] = 1;

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) continue;

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int w = edge.second;

                if (dist[v] == -1 || dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    zeroPaths[v] = 0;
                    onePaths[v] = 0;
                    if (w == 0) {
                        zeroPaths[v] = (zeroPaths[v] + zeroPaths[u]) % mod;
                        onePaths[v] = (onePaths[v] + onePaths[u]) % mod;
                    } else {
                        onePaths[v] = (onePaths[v] + zeroPaths[u]) % mod;
                        onePaths[v] = (onePaths[v] + onePaths[u]) % mod;
                    }
                    pq.push({dist[v], v});
                } else if (dist[v] == dist[u] + w) {
                    if (w == 0) {
                        zeroPaths[v] = (zeroPaths[v] + zeroPaths[u]) % mod;
                        onePaths[v] = (onePaths[v] + onePaths[u]) % mod;
                    } else {
                        onePaths[v] = (onePaths[v] + zeroPaths[u]) % mod;
                        onePaths[v] = (onePaths[v] + onePaths[u]) % mod;
                    }
                }
            }
        }

        return (zeroPaths[n] + onePaths[n]) % mod;
    }
};