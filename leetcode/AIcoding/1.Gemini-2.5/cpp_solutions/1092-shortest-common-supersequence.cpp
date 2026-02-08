#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string shortestCommonSupersequence(std::string str1, std::string str2) {
        int n = str1.length();
        int m = str2.length();

        std::vector<std::vector<int>> dp(n + 1, std::vector<int>(m + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                if (str1[i - 1] == str2[j - 1]) {
                    dp[i][j] = 1 + dp[i - 1][j - 1];
                } else {
                    dp[i][j] = std::max(dp[i - 1][j], dp[i][j - 1]);
                }
            }
        }

        std::string res = "";
        int i = n;
        int j = m;

        while (i > 0 && j > 0) {
            if (str1[i - 1] == str2[j - 1]) {
                res.push_back(str1[i - 1]);
                i--;
                j--;
            } else {
                if (dp[i - 1][j] > dp[i][j - 1]) {
                    res.push_back(str1[i - 1]);
                    i--;
                } else {
                    res.push_back(str2[j - 1]);
                    j--;
                }
            }
        }

        while (i > 0) {
            res.push_back(str1[i - 1]);
            i--;
        }

        while (j > 0) {
            res.push_back(str2[j - 1]);
            j--;
        }

        std::reverse(res.begin(), res.end());

        return res;
    }
};