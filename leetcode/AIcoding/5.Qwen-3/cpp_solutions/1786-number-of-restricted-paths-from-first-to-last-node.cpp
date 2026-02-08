#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countRestrictedPaths(const vector<vector<int>>& graph, int n, int k) {
        vector<vector<int>> adj(n + 1);
        for (const auto& edge : graph) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n + 1, INT_MAX);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        dist[1] = 0;
        pq.push({0, 1});

        while (!pq.empty()) {
            int u = pq.top().second;
            int d = pq.top().first;
            pq.pop();
            if (d > dist[u]) continue;
            for (int v : adj[u]) {
                if (dist[v] > dist[u] + 1) {
                    dist[v] = dist[u] + 1;
                    pq.push({dist[v], v});
                }
            }
        }

        vector<int> nodes(n + 1);
        for (int i = 1; i <= n; ++i) {
            nodes[i] = i;
        }

        sort(nodes.begin() + 1, nodes.end(), [&](int a, int b) {
            return dist[a] < dist[b];
        });

        unordered_map<int, int> order;
        for (int i = 1; i <= n; ++i) {
            order[nodes[i]] = i;
        }

        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));
        dp[n][order[n]] = 1;

        for (int i = n - 1; i >= 1; --i) {
            int u = nodes[i];
            for (int v : adj[u]) {
                if (order[v] > order[u]) {
                    dp[i][order[v]] = (dp[i][order[v]] + dp[order[v]][order[v]]) % k;
                }
            }
        }

        return dp[1][order[n]];
    }
};