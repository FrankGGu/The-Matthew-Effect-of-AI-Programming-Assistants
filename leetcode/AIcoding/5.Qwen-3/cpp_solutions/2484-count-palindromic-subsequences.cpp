#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countPalindromicSubsequences(string s) {
        int n = s.length();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<vector<int>> first(n, vector<int>(26, -1));
        vector<vector<int>> last(n, vector<int>(26, -1));

        for (int i = 0; i < n; ++i) {
            for (int c = 0; c < 26; ++c) {
                first[i][c] = -1;
                last[i][c] = -1;
            }
            for (int c = 0; c < 26; ++c) {
                if (s[i] == c + 'a') {
                    first[i][c] = i;
                } else {
                    first[i][c] = first[i - 1][c];
                }
                if (s[i] == c + 'a') {
                    last[i][c] = i;
                } else {
                    last[i][c] = last[i - 1][c];
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i + len - 1 < n; ++i) {
                int j = i + len - 1;
                dp[i][j] = dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1];
                if (s[i] == s[j]) {
                    dp[i][j] += 2;
                    for (int c = 0; c < 26; ++c) {
                        if (first[i + 1][c] != -1 && last[j - 1][c] != -1) {
                            if (first[i + 1][c] <= last[j - 1][c]) {
                                dp[i][j] += 1;
                            }
                        }
                    }
                }
            }
        }

        return dp[0][n - 1];
    }
};