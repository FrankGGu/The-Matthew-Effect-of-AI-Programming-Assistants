class Solution {
public:
    int mergeStones(vector<int>& stones, int K) {
        int n = stones.size();
        if ((n - 1) % (K - 1) != 0) return -1;

        vector<vector<int>> dp(n + 1, vector<int>(n + 1, INT_MAX));
        vector<vector<int>> prefix(n + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= n; ++i) {
            prefix[i][i] = stones[i - 1];
            for (int j = i + 1; j <= n; ++j) {
                prefix[i][j] = prefix[i][j - 1] + stones[j - 1];
            }
        }

        for (int len = 1; len <= n; ++len) {
            for (int i = 1; i <= n - len + 1; ++i) {
                int j = i + len - 1;
                if (len == 1) {
                    dp[i][j] = 0;
                } else {
                    for (int k = 1; k < len; ++k) {
                        dp[i][j] = min(dp[i][j], dp[i][i + k - 1] + dp[i + k][j]);
                    }
                    if ((len - 1) % (K - 1) == 0) {
                        dp[i][j] += prefix[i][j];
                    }
                }
            }
        }

        return dp[1][n];
    }
};