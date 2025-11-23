#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPalindrome(string s, int k) {
        int n = s.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int length = 2; length <= n; ++length) {
            for (int i = 0; i <= n - length; ++i) {
                int j = i + length - 1;
                if (s[i] == s[j]) {
                    dp[i][j] = 2 + (length > 2 ? dp[i+1][j-1] : 0);
                } else {
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1]);
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                int changes = (j - i + 1) - dp[i][j];
                if (changes <= k) {
                    result = max(result, j - i + 1);
                }
            }
        }

        return result;
    }
};