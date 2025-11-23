#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumTime(int n, vector<vector<int>>& edges, vector<int>& nodeTime) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<long long> dp(n, 1e18);
        dp[0] = 0;

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        pq.push({0, 0});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dp[u]) continue;

            for (int v : adj[u]) {
                long long weight = max(1, nodeTime[u] - (long long)d);
                if (dp[v] > dp[u] + weight) {
                    dp[v] = dp[u] + weight;
                    pq.push({dp[v], v});
                }
            }
        }

        return dp[n - 1];
    }
};