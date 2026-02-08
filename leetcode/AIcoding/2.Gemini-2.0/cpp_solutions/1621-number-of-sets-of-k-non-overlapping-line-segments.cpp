#include <vector>

using namespace std;

class Solution {
public:
    int numberOfSets(int n, int k) {
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(n, vector<vector<int>>(k + 1, vector<int>(2, 0)));

        for (int i = 0; i < n; ++i) {
            dp[i][0][0] = 1;
        }

        for (int j = 1; j <= k; ++j) {
            for (int i = 1; i < n; ++i) {
                dp[i][j][0] = (dp[i - 1][j][0] + dp[i - 1][j][1]) % MOD;
                dp[i][j][1] = (dp[i - 1][j][1] + dp[i - 1][j - 1][0] + dp[i - 1][j - 1][1] + dp[i - 1][j][0]) % MOD;
            }
        }

        return (dp[n - 1][k][0] + dp[n - 1][k][1]) % MOD;
    }
};