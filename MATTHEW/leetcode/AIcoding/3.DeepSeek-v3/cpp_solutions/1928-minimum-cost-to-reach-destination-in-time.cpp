class Solution {
public:
    int minCost(int maxTime, vector<vector<int>>& edges, vector<int>& passingFees) {
        int n = passingFees.size();
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], time = edge[2];
            graph[u].emplace_back(v, time);
            graph[v].emplace_back(u, time);
        }

        vector<vector<int>> dp(maxTime + 1, vector<int>(n, INT_MAX));
        dp[0][0] = passingFees[0];

        for (int t = 0; t <= maxTime; ++t) {
            for (int u = 0; u < n; ++u) {
                if (dp[t][u] == INT_MAX) continue;
                for (const auto& [v, time] : graph[u]) {
                    int newTime = t + time;
                    if (newTime > maxTime) continue;
                    if (dp[newTime][v] > dp[t][u] + passingFees[v]) {
                        dp[newTime][v] = dp[t][u] + passingFees[v];
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int t = 0; t <= maxTime; ++t) {
            result = min(result, dp[t][n - 1]);
        }
        return result == INT_MAX ? -1 : result;
    }
};