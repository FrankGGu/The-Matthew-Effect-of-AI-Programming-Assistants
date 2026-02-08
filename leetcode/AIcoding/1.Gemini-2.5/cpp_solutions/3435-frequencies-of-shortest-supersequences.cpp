#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int shortestCommonSupersequence(std::string str1, std::string str2) {
        int n = str1.length();
        int m = str2.length();
        long long MOD = 1e9 + 7;

        std::vector<std::vector<std::pair<int, long long>>> dp(n + 1, std::vector<std::pair<int, long long>>(m + 1));

        dp[0][0] = {0, 1};

        for (int i = 1; i <= n; ++i) {
            dp[i][0] = {i, 1};
        }

        for (int j = 1; j <= m; ++j) {
            dp[0][j] = {j, 1};
        }

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (str1[i - 1] == str2[j - 1]) {
                    dp[i][j] = {dp[i - 1][j - 1].first + 1, dp[i - 1][j - 1].second};
                } else {
                    int len1 = dp[i - 1][j].first + 1;
                    long long count1 = dp[i - 1][j].second;

                    int len2 = dp[i][j - 1].first + 1;
                    long long count2 = dp[i][j - 1].second;

                    if (len1 < len2) {
                        dp[i][j] = {len1, count1};
                    } else if (len2 < len1) {
                        dp[i][j] = {len2, count2};
                    } else {
                        dp[i][j] = {len1, (count1 + count2) % MOD};
                    }
                }
            }
        }

        return dp[n][m].second;
    }
};