class Solution {
public:
    int mergeStones(vector<int>& stones, int K) {
        int n = stones.size();
        if ((n - 1) % (K - 1) != 0) return -1;

        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + stones[i];
        }

        vector<vector<vector<int>>> dp(n, vector<vector<int>>(n, vector<int>(K + 1, 0)));

        for (int len = K; len <= n; ++len) {
            for (int i = 0; i + len <= n; ++i) {
                int j = i + len - 1;
                for (int k = 2; k <= K; ++k) {
                    dp[i][j][k] = INT_MAX;
                    for (int m = i; m < j; m += K - 1) {
                        dp[i][j][k] = min(dp[i][j][k], dp[i][m][1] + dp[m + 1][j][k - 1]);
                    }
                }
                dp[i][j][1] = dp[i][j][K] + prefix[j + 1] - prefix[i];
            }
        }

        return dp[0][n - 1][1];
    }
};