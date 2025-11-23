class Solution {
public:
    int numberOfWays(int n, vector<vector<int>>& edges) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dp(n, 0);
        dp[0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int neighbor : graph[i]) {
                dp[neighbor] = (dp[neighbor] + dp[i]) % MOD;
            }
        }

        return dp[n - 1];
    }
};