class Solution {
public:
    int stoneGameV(vector<int>& stoneValue) {
        int n = stoneValue.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<int> prefixSum(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stoneValue[i];
        }

        for (int length = 1; length <= n; ++length) {
            for (int i = 0; i + length - 1 < n; ++i) {
                int j = i + length - 1;
                for (int k = i; k < j; ++k) {
                    int left = prefixSum[k + 1] - prefixSum[i];
                    int right = prefixSum[j + 1] - prefixSum[k + 1];

                    if (left > right) {
                        dp[i][j] = max(dp[i][j], dp[i][k]);
                    } else if (left < right) {
                        dp[i][j] = max(dp[i][j], dp[k + 1][j]);
                    } else {
                        dp[i][j] = max(dp[i][j], left + max(dp[i][k], dp[k + 1][j]));
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
};