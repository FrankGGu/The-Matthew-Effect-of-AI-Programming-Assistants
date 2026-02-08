#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int distinctSubseqA(char a, char b, char c) {
        const int MOD = 1e9 + 7;
        vector<long long> dp(4, 0);
        dp[0] = 1;
        for (int i = 0; i < 3; ++i) {
            dp[i + 1] = (dp[i] * 2 - dp[i - 1]) % MOD;
        }
        return dp[3];
    }

    int countPalindromicSubsequences(int n, string s) {
        const int MOD = 1e9 + 7;
        vector<vector<int>> first(26, vector<int>(n, -1));
        vector<vector<int>> last(26, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < 26; ++j) {
                first[j][i] = first[j][i - 1];
                last[j][i] = last[j][i - 1];
            }
            first[s[i] - 'a'][i] = i;
            last[s[i] - 'a'][i] = i;
        }

        vector<vector<vector<long long>>> dp(n, vector<vector<long long>>(n, vector<long long>(4, 0)));

        for (int i = 0; i < n; ++i) {
            dp[i][i][0] = 1;
            dp[i][i][1] = 1;
            dp[i][i][2] = 1;
            dp[i][i][3] = 1;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                dp[i][j][0] = (dp[i + 1][j][0] + dp[i][j - 1][0] - dp[i + 1][j - 1][0]) % MOD;
                dp[i][j][1] = (dp[i + 1][j][1] + dp[i][j - 1][1] - dp[i + 1][j - 1][1]) % MOD;
                dp[i][j][2] = (dp[i + 1][j][2] + dp[i][j - 1][2] - dp[i + 1][j - 1][2]) % MOD;
                dp[i][j][3] = (dp[i + 1][j][3] + dp[i][j - 1][3] - dp[i + 1][j - 1][3]) % MOD;

                if (s[i] == s[j]) {
                    dp[i][j][0] = (dp[i][j][0] + 1) % MOD;
                    dp[i][j][1] = (dp[i][j][1] + 1) % MOD;
                    dp[i][j][2] = (dp[i][j][2] + 1) % MOD;
                    dp[i][j][3] = (dp[i][j][3] + 1) % MOD;

                    for (int k = 0; k < 26; ++k) {
                        int left = first[k][j - 1];
                        int right = last[k][i + 1];
                        if (left != -1 && right != -1) {
                            if (left == right) {
                                dp[i][j][0] = (dp[i][j][0] + 1) % MOD;
                            } else {
                                dp[i][j][0] = (dp[i][j][0] + dp[left + 1][right - 1][0]) % MOD;
                            }
                        }
                    }
                }
            }
        }

        return (dp[0][n - 1][3] - 3) % MOD;
    }
};