#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int maxPalindromes(std::string s, int k) {
        int n = s.length();

        // Step 1: Precompute all palindromic substrings
        // is_palindrome[i][j] is true if s[i...j] is a palindrome
        std::vector<std::vector<bool>> is_palindrome(n, std::vector<bool>(n, false));

        // Palindromes of length 1
        for (int i = 0; i < n; ++i) {
            is_palindrome[i][i] = true;
        }

        // Palindromes of length 2
        for (int i = 0; i < n - 1; ++i) {
            if (s[i] == s[i+1]) {
                is_palindrome[i][i+1] = true;
            }
        }

        // Palindromes of length 3 or more
        for (int len = 3; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;
                if (s[i] == s[j] && is_palindrome[i+1][j-1]) {
                    is_palindrome[i][j] = true;
                }
            }
        }

        // Step 2: Dynamic programming to find maximum non-overlapping palindromes
        // dp[i] = maximum number of non-overlapping palindromes in s[0...i-1]
        std::vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            // Option 1: Don't include s[i-1] in any new palindrome,
            // so the count is the same as for s[0...i-2]
            dp[i] = dp[i-1];

            // Option 2: s[i-1] is the end of a new palindrome s[j...i-1]
            // This palindrome must have length at least k.
            // Length = (i-1) - j + 1 = i - j.
            // So, i - j >= k  =>  j <= i - k.
            // The starting index j can range from 0 to i - k.
            for (int j = 0; j <= i - k; ++j) {
                if (is_palindrome[j][i-1]) {
                    // If s[j...i-1] is a palindrome of length >= k
                    // We take this palindrome and add it to the count from s[0...j-1]
                    dp[i] = std::max(dp[i], (j > 0 ? dp[j] : 0) + 1);
                }
            }
        }

        return dp[n];
    }
};