class Solution {
public:
    const int MOD = 1e9 + 7;

    int numberOfWays(int startPos, int endPos, int k) {
        int diff = abs(endPos - startPos);
        if (diff > k || (k - diff) % 2 != 0) {
            return 0;
        }

        int right = (k + diff) / 2;
        int left = (k - diff) / 2;

        return comb(k, min(left, right));
    }

private:
    int comb(int n, int k) {
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));
        for (int i = 0; i <= n; ++i) {
            for (int j = 0; j <= min(i, k); ++j) {
                if (j == 0 || j == i) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % MOD;
                }
            }
        }
        return dp[n][k];
    }
};