#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minimumDeleteSum(std::string s1, std::string s2) {
        int m = s1.length();
        int n = s2.length();

        std::vector<std::vector<int>> dp(m + 1, std::vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                if (s1[i - 1] == s2[j - 1]) {
                    dp[i][j] = dp[i - 1][j - 1] + s1[i - 1];
                } else {
                    dp[i][j] = std::max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }

        int sum1 = std::accumulate(s1.begin(), s1.end(), 0);
        int sum2 = std::accumulate(s2.begin(), s2.end(), 0);

        return sum1 + sum2 - 2 * dp[m][n];
    }
};