#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int longestPalindromeSubsequence(const std::string& s) {
        int n = s.length();
        if (n == 0) {
            return 0;
        }

        std::vector<std::vector<int>> dp(n, std::vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j]) {
                    dp[i][j] = 2 + (len == 2 ? 0 : dp[i + 1][j - 1]);
                } else {
                    dp[i][j] = std::max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }
        return dp[0][n - 1];
    }

    int longestPalindrome(std::string word1, std::string word2) {
        std::string s = word1 + word2;
        int n1 = word1.length();
        int n2 = word2.length();
        int n = s.length();

        std::vector<std::vector<int>> dp(n, std::vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j]) {
                    dp[i][j] = 2 + (i + 1 > j - 1 ? 0 : dp[i + 1][j - 1]);
                } else {
                    dp[i][j] = std::max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        int max_palindrome_len = 0;

        // Case 1: Palindrome is entirely from word1 (sub2 is empty)
        // Case 2: Palindrome is entirely from word2 (sub1 is empty)
        // Constraints guarantee word1 and word2 are non-empty, so LPS will be at least 1.
        if (n1 > 0) {
            max_palindrome_len = std::max(max_palindrome_len, dp[0][n1 - 1]);
        }
        if (n2 > 0) {
            max_palindrome_len = std::max(max_palindrome_len, dp[n1][n - 1]);
        }

        // Case 3: Palindrome is formed by non-empty sub1 from word1 and non-empty sub2 from word2
        for (int i = 0; i < n1; ++i) { // Character from word1
            for (int j = n1; j < n; ++j) { // Character from word2
                if (s[i] == s[j]) {
                    int current_len = 2;
                    if (i + 1 <= j - 1) {
                        current_len += dp[i + 1][j - 1];
                    }
                    max_palindrome_len = std::max(max_palindrome_len, current_len);
                }
            }
        }

        return max_palindrome_len;
    }
};