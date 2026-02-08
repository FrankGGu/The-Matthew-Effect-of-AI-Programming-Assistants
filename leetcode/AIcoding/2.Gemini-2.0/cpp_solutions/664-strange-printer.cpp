#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int strangePrinter(string s) {
        int n = s.length();
        if (n == 0) return 0;

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                dp[i][j] = dp[i + 1][j] + 1;
                for (int k = i + 1; k <= j; ++k) {
                    if (s[i] == s[k]) {
                        dp[i][j] = min(dp[i][j], dp[i + 1][k] + dp[k + 1][j]);
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
};