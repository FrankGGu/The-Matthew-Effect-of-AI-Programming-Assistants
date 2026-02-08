class Solution {
public:
    int countArrays(int n, int m, int k) {
        const int MOD = 1e9 + 7;
        if (k < 0 || k >= n) return 0;

        vector<vector<vector<int>>> dp(n, vector<vector<int>>(k + 1, vector<int>(m + 1, 0)));

        for (int num = 1; num <= m; ++num) {
            dp[0][0][num] = 1;
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j <= k; ++j) {
                for (int num = 1; num <= m; ++num) {
                    if (j > 0) {
                        for (int prev_num = 1; prev_num <= m; ++prev_num) {
                            if (prev_num == num) {
                                dp[i][j][num] = (dp[i][j][num] + dp[i - 1][j - 1][prev_num]) % MOD;
                            }
                        }
                    }
                    for (int prev_num = 1; prev_num <= m; ++prev_num) {
                        if (prev_num != num) {
                            dp[i][j][num] = (dp[i][j][num] + dp[i - 1][j][prev_num]) % MOD;
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int num = 1; num <= m; ++num) {
            result = (result + dp[n - 1][k][num]) % MOD;
        }
        return result;
    }
};