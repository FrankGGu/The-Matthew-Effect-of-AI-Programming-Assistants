#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int minSkips(int target, vector<vector<int>>& edges, int start, int end) {
        int n = edges.size();
        vector<vector<pair<int, int>>> graph(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], time = edge[2];
            graph[u].push_back({v, time});
            graph[v].push_back({u, time});
        }

        vector<int> dist(n, INT_MAX);
        vector<int> skips(n, 0);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        pq.push({0, start});
        dist[start] = 0;

        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (u == end) break;

            for (auto& [v, t] : graph[u]) {
                if (d + t < dist[v]) {
                    dist[v] = d + t;
                    skips[v] = skips[u];
                    pq.push({dist[v], v});
                } else if (d + t == dist[v] && skips[u] < skips[v]) {
                    skips[v] = skips[u];
                    pq.push({dist[v], v});
                }
            }
        }

        if (dist[end] > target) return -1;

        vector<vector<int>> dp(n, vector<int>(n, INT_MAX));
        dp[start][0] = 0;

        for (int i = 0; i < n; ++i) {
            for (int k = 0; k < n; ++k) {
                if (dp[i][k] == INT_MAX) continue;
                for (auto& [j, t] : graph[i]) {
                    if (dp[j][k] > dp[i][k] + t) {
                        dp[j][k] = dp[i][k] + t;
                    }
                    if (dp[j][k + 1] > dp[i][k] + t) {
                        dp[j][k + 1] = dp[i][k] + t;
                    }
                }
            }
        }

        for (int k = 0; k < n; ++k) {
            if (dp[end][k] <= target) return k;
        }

        return -1;
    }
};