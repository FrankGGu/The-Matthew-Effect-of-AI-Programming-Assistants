class Solution {
public:
    int dieSimulator(int n, vector<int>& rollMax) {
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(6, vector<int>(16, 0)));

        for (int j = 0; j < 6; ++j) {
            dp[1][j][1] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 0; j < 6; ++j) {
                for (int k = 1; k <= rollMax[j]; ++k) {
                    if (k == 1) {
                        for (int l = 0; l < 6; ++l) {
                            if (l == j) continue;
                            for (int m = 1; m <= rollMax[l]; ++m) {
                                dp[i][j][k] = (dp[i][j][k] + dp[i - 1][l][m]) % MOD;
                            }
                        }
                    } else {
                        dp[i][j][k] = dp[i - 1][j][k - 1];
                    }
                }
            }
        }

        int res = 0;
        for (int j = 0; j < 6; ++j) {
            for (int k = 1; k <= rollMax[j]; ++k) {
                res = (res + dp[n][j][k]) % MOD;
            }
        }
        return res;
    }
};