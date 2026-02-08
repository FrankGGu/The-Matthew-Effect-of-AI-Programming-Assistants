class Solution {
public:
    int numWays(vector<string>& words, string target) {
        int m = words.size(), n = words[0].size(), t = target.size();
        vector<vector<long long>> dp(t + 1, vector<long long>(n + 1, 0));
        vector<vector<long long>> count(26, vector<long long>(n + 1, 0));

        for (int j = 0; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                count[words[i][j] - 'a'][j]++;
            }
        }

        dp[0][0] = 1;
        for (int j = 1; j <= n; ++j) {
            dp[0][j] = 1;
        }

        for (int i = 1; i <= t; ++i) {
            for (int j = 1; j <= n; ++j) {
                dp[i][j] = dp[i][j - 1];
                if (target[i - 1] - 'a' < 26) {
                    dp[i][j] += dp[i - 1][j - 1] * count[target[i - 1] - 'a'][j - 1];
                }
            }
        }

        return dp[t][n] % 1000000007;
    }
};