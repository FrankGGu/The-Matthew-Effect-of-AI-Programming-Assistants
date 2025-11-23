#include <vector>
#include <queue>
#include <algorithm>
using namespace std;

class Solution {
public:
    int countRestrictedPaths(int n, vector<vector<int>>& edges) {
        const int MOD = 1e9 + 7;
        vector<vector<pair<int, int>>> graph(n + 1);
        for (const auto& e : edges) {
            graph[e[0]].emplace_back(e[1], e[2]);
            graph[e[1]].emplace_back(e[0], e[2]);
        }

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        vector<int> dist(n + 1, INT_MAX);
        dist[n] = 0;
        pq.emplace(0, n);

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (d > dist[u]) continue;
            for (const auto& [v, w] : graph[u]) {
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.emplace(dist[v], v);
                }
            }
        }

        vector<pair<int, int>> nodes;
        for (int i = 1; i <= n; ++i) {
            nodes.emplace_back(dist[i], i);
        }
        sort(nodes.begin(), nodes.end());

        vector<int> dp(n + 1, 0);
        dp[n] = 1;

        for (const auto& [d, u] : nodes) {
            for (const auto& [v, w] : graph[u]) {
                if (dist[v] < dist[u]) {
                    dp[u] = (dp[u] + dp[v]) % MOD;
                }
            }
        }

        return dp[1];
    }
};