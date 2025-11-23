#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int tilingRectangle(int n, int m) {
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (i == j) {
                    dp[i][j] = 1;
                } else {
                    dp[i][j] = INT_MAX;
                    for (int k = 1; k < i; ++k) {
                        dp[i][j] = min(dp[i][j], dp[k][j] + dp[i - k][j]);
                    }
                    for (int k = 1; k < j; ++k) {
                        dp[i][j] = min(dp[i][j], dp[i][k] + dp[i][j - k]);
                    }
                }
            }
        }

        return dp[n][m];
    }
};