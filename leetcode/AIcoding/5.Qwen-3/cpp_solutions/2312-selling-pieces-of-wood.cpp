#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long sellWood(int m, int n, vector<vector<int>>& prices) {
        vector<vector<long long>> dp(m + 1, vector<long long>(n + 1, 0));

        for (const auto& price : prices) {
            int x = price[0];
            int y = price[1];
            int val = price[2];
            dp[x][y] = max(dp[x][y], (long long)val);
        }

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                for (int k = 1; k < i; ++k) {
                    dp[i][j] = max(dp[i][j], dp[k][j] + dp[i - k][j]);
                }
                for (int l = 1; l < j; ++l) {
                    dp[i][j] = max(dp[i][j], dp[i][l] + dp[i][j - l]);
                }
            }
        }

        return dp[m][n];
    }
};