#include <vector>

using namespace std;

class Solution {
public:
    int distinctSequences(int n) {
        int mod = 1e9 + 7;
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(7, vector<int>(7, 0)));

        for (int j = 1; j <= 6; ++j) {
            dp[1][0][j] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 1; j <= 6; ++j) {
                for (int k = 1; k <= 6; ++k) {
                    if (k != j) {
                        if (gcd(j, k) == 1) {
                            for (int l = 0; l <= 6; ++l) {
                                dp[i][j][k] = (dp[i][j][k] + dp[i - 1][l][j]) % mod;
                            }
                        }
                    }
                }
            }
        }

        int ans = 0;
        for (int j = 1; j <= 6; ++j) {
            for (int k = 1; k <= 6; ++k) {
                ans = (ans + dp[n][j][k]) % mod;
            }
        }

        return ans;
    }

private:
    int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};