class Solution {
public:
    int keyboard(int k, int n) {
        const int MOD = 1e9 + 7;
        vector<vector<long long>> dp(n + 1, vector<long long>(27, 0));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= 26; ++j) {
                for (int l = 0; l <= k; ++l) {
                    if (i - l >= 0) {
                        dp[i][j] = (dp[i][j] + dp[i - l][j - 1] * comb(l)) % MOD;
                    }
                }
            }
        }

        long long res = 0;
        for (int j = 1; j <= 26; ++j) {
            res = (res + dp[n][j]) % MOD;
        }
        return res;
    }

private:
    long long comb(int l) {
        if (l == 0) return 1;
        long long res = 1;
        for (int i = 1; i <= l; ++i) {
            res = res * (26 - i + 1) / i;
        }
        return res;
    }
};