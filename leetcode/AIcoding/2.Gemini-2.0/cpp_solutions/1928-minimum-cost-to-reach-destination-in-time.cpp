#include <vector>
#include <queue>
#include <tuple>

using namespace std;

class Solution {
public:
    int minCost(int maxTime, vector<vector<int>>& edges, vector<int>& passingFees) {
        int n = passingFees.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], time = edge[2];
            adj[u].push_back({v, time});
            adj[v].push_back({u, time});
        }

        vector<vector<int>> dp(n, vector<int>(maxTime + 1, INT_MAX));
        dp[0][0] = passingFees[0];

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.push({passingFees[0], 0, 0});

        while (!pq.empty()) {
            auto [cost, time, u] = pq.top();
            pq.pop();

            if (cost > dp[u][time]) continue;

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first, t = neighbor.second;
                if (time + t <= maxTime) {
                    int new_cost = cost + passingFees[v];
                    if (new_cost < dp[v][time + t]) {
                        dp[v][time + t] = new_cost;
                        pq.push({new_cost, time + t, v});
                    }
                }
            }
        }

        int min_cost = INT_MAX;
        for (int i = 0; i <= maxTime; ++i) {
            min_cost = min(min_cost, dp[n - 1][i]);
        }

        return (min_cost == INT_MAX) ? -1 : min_cost;
    }
};