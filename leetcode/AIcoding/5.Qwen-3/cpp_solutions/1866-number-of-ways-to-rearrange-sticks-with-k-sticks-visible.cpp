#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int rearrangeSticks(int n, int k) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            dp[i][1] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 2; j <= k; ++j) {
                for (int m = 1; m <= i; ++m) {
                    dp[i][j] += dp[i - m][j - 1];
                    dp[i][j] %= MOD;
                }
            }
        }

        return dp[n][k];
    }
};