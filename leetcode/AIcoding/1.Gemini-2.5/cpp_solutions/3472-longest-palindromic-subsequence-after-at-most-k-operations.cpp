#include <vector>
#include <string>
#include <algorithm>

class Solution {
public:
    int longestPalindromeSubsequence(std::string s, int k) {
        int n = s.length();

        // Optimization: If k is large enough, we can make the entire string a palindrome.
        // To make a subsequence of length L a palindrome, we need at most floor(L/2) operations.
        // If we want to make the entire string (length n) a palindrome, we need at most floor(n/2) operations.
        // If k is greater than or equal to floor(n/2), we can always achieve a palindromic subsequence of length n.
        if (k >= n / 2) {
            return n;
        }

        // dp[i][j][ops] stores the maximum length of a palindromic subsequence
        // using characters from s[i...j] with at most 'ops' operations.
        // The 'ops' dimension goes up to k.
        // The maximum value for 'ops' that needs to be considered is floor(n/2) - 1,
        // as k >= floor(n/2) is handled above. So the third dimension size is k+1.
        std::vector<std::vector<std::vector<int>>> dp(n, std::vector<std::vector<int>>(n, std::vector<int>(k + 1, 0)));

        // Base case: A single character is a palindrome of length 1, requiring 0 operations.
        // This holds for any number of available operations, as they are not needed.
        for (int i = 0; i < n; ++i) {
            for (int ops = 0; ops <= k; ++ops) {
                dp[i][i][ops] = 1;
            }
        }

        // Fill the DP table for subsequences of increasing length
        // 'len' represents the length of the current substring s[i...j]
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;

                for (int ops = 0; ops <= k; ++ops) {
                    // Option 1: Don't include s[i] in the subsequence
                    // The max length is from s[i+1...j] with 'ops' operations.
                    dp[i][j][ops] = std::max(dp[i][j][ops], dp[i + 1][j][ops]);

                    // Option 2: Don't include s[j] in the subsequence
                    // The max length is from s[i...j-1] with 'ops' operations.
                    dp[i][j][ops] = std::max(dp[i][j][ops], dp[i][j - 1][ops]);

                    // Option 3: Include both s[i] and s[j] in the subsequence
                    // This contributes 2 to the length.
                    // We need to find the LPS of the inner substring s[i+1...j-1].
                    // The length of the inner substring is len - 2.
                    // If len == 2, the inner substring is empty, and its LPS length is 0.
                    // dp[i+1][j-1][...] will correctly return 0 for i+1 > j-1 (empty range).

                    if (s[i] == s[j]) {
                        // If s[i] and s[j] match, no operation is needed for this pair.
                        // We use 'ops' operations for the inner subsequence.
                        dp[i][j][ops] = std::max(dp[i][j][ops], 2 + dp[i + 1][j - 1][ops]);
                    } else {
                        // If s[i] and s[j] do not match, 1 operation is needed for this pair.
                        // We must have at least 1 operation available (ops > 0).
                        if (ops > 0) {
                            // Use ops-1 operations for the inner subsequence.
                            dp[i][j][ops] = std::max(dp[i][j][ops], 2 + dp[i + 1][j - 1][ops - 1]);
                        }
                    }
                }
            }
        }

        // The final answer is the maximum length of a palindromic subsequence
        // for the entire string s[0...n-1] with at most k operations.
        return dp[0][n - 1][k];
    }
};