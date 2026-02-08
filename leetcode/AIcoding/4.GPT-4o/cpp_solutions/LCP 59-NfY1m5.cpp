class Solution {
public:
    int numWays(int n, vector<vector<int>>& relations, int k) {
        vector<vector<int>> dp(n, vector<int>(k + 1, 0));
        dp[0][0] = 1;

        for (int step = 1; step <= k; ++step) {
            for (const auto& relation : relations) {
                int from = relation[0], to = relation[1];
                dp[to][step] = (dp[to][step] + dp[from][step - 1]) % 1000000007;
            }
        }

        return dp[n - 1][k];
    }
};