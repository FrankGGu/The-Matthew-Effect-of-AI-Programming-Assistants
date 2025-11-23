#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfWays(string s, vector<vector<int>>& knowledge) {
        unordered_map<string, string> map;
        for (auto& pair : knowledge) {
            map[pair[0]] = pair[1];
        }

        int n = s.length();
        vector<vector<int>> dp(n + 1, vector<int>(n + 1, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j]) {
                    dp[i][j] = dp[i + 1][j - 1];
                } else {
                    dp[i][j] = 0;
                }

                for (int k = i; k < j; ++k) {
                    dp[i][j] += dp[i][k] * dp[k + 1][j];
                }
            }
        }

        return dp[0][n - 1];
    }
};