#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Solution {
public:
    int countRestrictedPaths(int n, vector<vector<int>>& edges) {
        vector<vector<pair<int, int>>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
            adj[edge[1]].push_back({edge[0], edge[2]});
        }

        vector<int> dist(n + 1, numeric_limits<int>::max());
        dist[n] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, n});

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

        vector<int> dp(n + 1, 0);
        dp[n] = 1;

        function<int(int)> dfs = [&](int u) {
            if (dp[u] != 0) return dp[u];

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                if (dist[v] < dist[u]) {
                    dp[u] = (dp[u] + dfs(v)) % 1000000007;
                }
            }
            return dp[u];
        };

        return dfs(1);
    }
};