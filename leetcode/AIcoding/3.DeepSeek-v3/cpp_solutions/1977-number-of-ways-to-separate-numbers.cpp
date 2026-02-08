class Solution {
public:
    const int MOD = 1e9 + 7;

    int numberOfCombinations(string num) {
        if (num[0] == '0') return 0;
        int n = num.size();
        vector<vector<int>> lcp(n + 1, vector<int>(n + 1, 0));
        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (num[i] == num[j]) {
                    lcp[i][j] = lcp[i + 1][j + 1] + 1;
                }
            }
        }
        vector<vector<int>> dp(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) dp[0][i] = 1;
        for (int i = 1; i < n; ++i) {
            if (num[i] == '0') continue;
            int prefix = 0;
            for (int j = i; j < n; ++j) {
                int len = j - i + 1;
                int prevStart = i - 1 - (len - 1);
                int cnt = 0;
                if (prevStart < 0) {
                    cnt = dp[i - 1][i - 1];
                } else {
                    int maxLen = lcp[prevStart][i];
                    if (maxLen >= len || num[prevStart + maxLen] < num[i + maxLen]) {
                        cnt = (dp[i - 1][i - 1] - (prevStart == 0 ? 0 : dp[prevStart - 1][i - 1]) + MOD) % MOD;
                    } else {
                        cnt = (dp[i - 1][i - 1] - (prevStart == 0 ? 0 : dp[prevStart - 1][i - 1]) - dp[prevStart][i - 1] + (prevStart == 0 ? 0 : dp[prevStart - 1][i - 1]) + MOD) % MOD;
                    }
                    cnt = (cnt + (prevStart == 0 ? 0 : dp[prevStart - 1][prevStart + len - 1])) % MOD;
                }
                dp[i][j] = (prefix + cnt) % MOD;
                prefix = (prefix + cnt) % MOD;
            }
        }
        return dp[n - 1][n - 1];
    }
};