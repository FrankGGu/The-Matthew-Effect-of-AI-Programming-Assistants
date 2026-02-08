class Solution {
public:
    int distinctSequences(int n) {
        if (n == 1) return 6;
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(7, vector<int>(7, 0)));

        for (int i = 1; i <= 6; ++i) {
            for (int j = 1; j <= 6; ++j) {
                if (i != j && __gcd(i, j) == 1) {
                    dp[2][i][j] = 1;
                }
            }
        }

        for (int len = 3; len <= n; ++len) {
            for (int prev2 = 1; prev2 <= 6; ++prev2) {
                for (int prev1 = 1; prev1 <= 6; ++prev1) {
                    if (prev1 == prev2 || __gcd(prev1, prev2) != 1) continue;
                    for (int curr = 1; curr <= 6; ++curr) {
                        if (curr == prev1 || curr == prev2 || __gcd(curr, prev1) != 1) continue;
                        dp[len][prev1][curr] = (dp[len][prev1][curr] + dp[len - 1][prev2][prev1]) % MOD;
                    }
                }
            }
        }

        int res = 0;
        for (int i = 1; i <= 6; ++i) {
            for (int j = 1; j <= 6; ++j) {
                res = (res + dp[n][i][j]) % MOD;
            }
        }
        return res;
    }
};