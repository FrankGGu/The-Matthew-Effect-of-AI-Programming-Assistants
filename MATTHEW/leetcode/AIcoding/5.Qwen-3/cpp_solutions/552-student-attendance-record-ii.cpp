#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int checkRecord(int n) {
        const int MOD = 1000000007;
        vector<vector<int>> dp(n + 1, vector<int>(3, 0));
        dp[0][0] = 1;
        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < 3; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
                }
                if (i >= 2 && j >= 1) {
                    dp[i][j] = (dp[i][j] + dp[i - 2][j - 1]) % MOD;
                }
            }
        }
        int total = 0;
        for (int j = 0; j < 3; ++j) {
            total = (total + dp[n][j]) % MOD;
        }
        return total;
    }
};