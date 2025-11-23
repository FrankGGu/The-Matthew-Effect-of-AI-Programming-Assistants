#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countDifferentPalindromicSubsequences(string s) {
        int n = s.length();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j]) {
                    if (length == 2) {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] * 2;
                        int left = i + 1;
                        int right = j - 1;
                        while (left <= right && s[left] != s[i]) {
                            ++left;
                        }
                        while (left <= right && s[right] != s[j]) {
                            --right;
                        }
                        if (left > right) {
                            dp[i][j] += 2;
                        } else if (left == right) {
                            dp[i][j] += 1;
                        } else {
                            dp[i][j] -= dp[left + 1][right - 1];
                        }
                    }
                } else {
                    dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                }
            }
        }

        return dp[0][n - 1];
    }
};