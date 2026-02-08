class Solution {
public:
    int countWays(int n, vector<vector<int>>& edges) {
        const int MOD = 1e9 + 7;
        vector<unordered_map<int, long long>> dp(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            dp[u][1] = (dp[u][1] + 1) % MOD;
            dp[v][1] = (dp[v][1] + 1) % MOD;
            dp[u][0] = (dp[u][0] + 1) % MOD;
            dp[v][0] = (dp[v][0] + 1) % MOD;
        }
        long long result = 1;
        for (int i = 0; i < n; ++i) {
            result = (result * (dp[i][0] + dp[i][1])) % MOD;
        }
        return result;
    }
};