#include <vector>
#include <string>
#include <numeric>
#include <algorithm> // For std::fill

class Solution {
public:
    int countPalindromicSubsequences(std::string s) {
        int n = s.length();
        long long MOD = 1e9 + 7;

        // dp[i][j] stores the number of different palindromic subsequences in s[i...j]
        std::vector<std::vector<long long>> dp(n, std::vector<long long>(n, 0));

        // next_occurrence[k][char_code] stores the index of the next occurrence of char_code at or after k
        std::vector<std::vector<int>> next_occurrence(n, std::vector<int>(4));
        // prev_occurrence[k][char_code] stores the index of the previous occurrence of char_code at or before k
        std::vector<std::vector<int>> prev_occurrence(n, std::vector<int>(4));

        // Precompute next_occurrence
        std::vector<int> last_seen(4, n); // Initialize with n (out of bounds)
        for (int i = n - 1; i >= 0; --i) {
            for (int c = 0; c < 4; ++c) {
                next_occurrence[i][c] = last_seen[c];
            }
            last_seen[s[i] - 'a'] = i;
        }

        // Precompute prev_occurrence
        std::fill(last_seen.begin(), last_seen.end(), -1); // Initialize with -1 (out of bounds)
        for (int i = 0; i < n; ++i) {
            for (int c = 0; c < 4; ++c) {
                prev_occurrence[i][c] = last_seen[c];
            }
            last_seen[s[i] - 'a'] = i;
        }

        // Base case: length 1 subsequences
        for (int i = 0; i < n; ++i) {
            dp[i][i] = 1; // Each single character is a palindrome
        }

        // Fill DP table for lengths from 2 to n
        for (int len = 2; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1;

                if (s[i] != s[j]) {
                    // If s[i] and s[j] are different,
                    // palindromes are from s[i+1...j] + s[i...j-1] - s[i+1...j-1] (to remove duplicates)
                    dp[i][j] = (dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + MOD) % MOD;
                } else { // s[i] == s[j]
                    int char_val = s[i] - 'a';
                    int first_inner = next_occurrence[i+1][char_val]; // First occurrence of s[i] in s[i+1...j-1]
                    int last_inner = prev_occurrence[j-1][char_val];  // Last occurrence of s[j] in s[i+1...j-1]

                    if (first_inner > last_inner) {
                        // Case 1: No other character 'c' (s[i]) in between i and j.
                        // Palindromes are:
                        // 1. All palindromes from s[i+1...j-1] (dp[i+1][j-1])
                        // 2. 'c' (single character s[i])
                        // 3. 'cc' (two characters s[i]s[j])
                        // Total: dp[i+1][j-1] + 2
                        dp[i][j] = (2 + dp[i+1][j-1]) % MOD;
                    } else if (first_inner == last_inner) {
                        // Case 2: Exactly one character 'c' (s[i]) in between i and j.
                        // Example: "aaa" for i=0, j=2. s[1] is 'a'.
                        // Palindromes are:
                        // 1. All palindromes from s[i+1...j-1] (dp[i+1][j-1])
                        // 2. 'ccc' (s[i]s[first_inner]s[j])
                        // Total: dp[i+1][j-1] + 1
                        dp[i][j] = (1 + dp[i+1][j-1]) % MOD;
                    } else { // first_inner < last_inner
                        // Case 3: At least two characters 'c' (s[i]) in between i and j.
                        // Example: "aabbaa" for i=0, j=5. s[1]='a', s[4]='a'.
                        // The formula is derived from considering:
                        //   - Palindromes from s[first_inner...last_inner] (dp[first_inner][last_inner])
                        //   - Palindromes of form s[i] + P + s[j] where P is a palindrome from s[first_inner...last_inner].
                        //     This adds another dp[first_inner][last_inner] distinct palindromes.
                        // This sum (2 * dp[first_inner][last_inner]) overcounts palindromes that are formed
                        // by s[first_inner] and s[last_inner] and their inner part.
                        // Specifically, palindromes of the form s[first_inner] + P' + s[last_inner] where P'
                        // is a palindrome from s[first_inner+1...last_inner-1] are counted twice.
                        // So, we subtract dp[first_inner+1][last_inner-1] to correct for this overcounting.
                        dp[i][j] = (2 * dp[first_inner][last_inner] - dp[first_inner+1][last_inner-1] + MOD + MOD) % MOD;
                    }
                }
            }
        }

        return dp[0][n-1];
    }
};