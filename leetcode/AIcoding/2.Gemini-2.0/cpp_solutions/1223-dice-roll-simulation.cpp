#include <vector>

using namespace std;

class Solution {
public:
    int dieSimulator(int n, vector<int>& rollMax) {
        int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(6, vector<int>(16, 0)));
        for (int i = 0; i < 6; ++i) {
            dp[1][i][1] = 1;
        }
        for (int i = 2; i <= n; ++i) {
            for (int j = 0; j < 6; ++j) {
                for (int k = 1; k <= rollMax[j]; ++k) {
                    for (int l = 0; l < 6; ++l) {
                        if (l != j) {
                            for (int m = 1; m <= rollMax[l]; ++m) {
                                dp[i][j][1] = (dp[i][j][1] + dp[i - 1][l][m]) % MOD;
                            }
                        } else {
                            if (k > 1) {
                                dp[i][j][k] = dp[i - 1][j][k - 1];
                            }
                        }
                    }
                }
            }
        }
        int ans = 0;
        for (int i = 0; i < 6; ++i) {
            for (int j = 1; j <= rollMax[i]; ++j) {
                ans = (ans + dp[n][i][j]) % MOD;
            }
        }
        return ans;
    }
};