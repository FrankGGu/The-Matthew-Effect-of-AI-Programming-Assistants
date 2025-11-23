#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestPalindrome(string word1, string word2) {
        string s = word1 + word2;
        int n1 = word1.size();
        int n2 = word2.size();
        int n = s.size();

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j]) {
                    if (len == 2) {
                        dp[i][j] = 2;
                    } else {
                        dp[i][j] = dp[i + 1][j - 1] + 2;
                    }
                } else {
                    dp[i][j] = max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        int ans = 0;
        for (int i = 0; i < n1; ++i) {
            for (int j = n1; j < n; ++j) {
                if (word1[i] == word2[j - n1]) {
                    ans = max(ans, dp[i][j]);
                }
            }
        }

        return ans;
    }
};