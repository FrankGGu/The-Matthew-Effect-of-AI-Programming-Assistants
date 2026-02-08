#include <vector>

using namespace std;

class Solution {
public:
    int mod = 1e9 + 7;

    int numberOfWays(int n, int k) {
        vector<vector<vector<int>>> dp(n + 1, vector<vector<int>>(k + 1, vector<int>(2, 0)));
        dp[0][0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j][0] = (dp[i - 1][j][0] + dp[i - 1][j][1]) % mod;
                if (j > 0) {
                    dp[i][j][1] = dp[i - 1][j - 1][0];
                }
            }
        }

        return (dp[n][k][0] + dp[n][k][1]) % mod;
    }
};