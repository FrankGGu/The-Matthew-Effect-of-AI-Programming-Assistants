#include <string.h>
#include <stdlib.h>

int countPalindromicSubsequences(char * s){
    int N = strlen(s);
    long long MOD = 1000000007;

    // dp[i][j] stores the number of different palindromic subsequences in s[i...j]
    long long** dp = (long long**)malloc(N * sizeof(long long*));
    for (int i = 0; i < N; ++i) {
        dp[i] = (long long*)calloc(N, sizeof(long long)); // Initialize with 0
    }

    // Precompute next_char_occurrence and prev_char_occurrence
    // next_char_occurrence[i] stores the index of the next occurrence of s[i] after i.
    // prev_char_occurrence[i] stores the index of the previous occurrence of s[i] before i.
    int* next_char_occurrence = (int*)malloc(N * sizeof(int));
    int* prev_char_occurrence = (int*)malloc(N * sizeof(int));

    int last_seen[4]; // For 'a', 'b', 'c', 'd'
    for (int k = 0; k < 4; ++k) last_seen[k] = -1; // Initialize with -1 (not seen)

    for (int i = N - 1; i >= 0; --i) {
        next_char_occurrence[i] = last_seen[s[i] - 'a'];
        last_seen[s[i] - 'a'] = i;
    }

    for (int k = 0; k < 4; ++k) last_seen[k] = -1; // Reset for prev_char_occurrence
    for (int i = 0; i < N; ++i) {
        prev_char_occurrence[i] = last_seen[s[i] - 'a'];
        last_seen[s[i] - 'a'] = i;
    }

    // Fill DP table
    for (int i = 0; i < N; ++i) {
        dp[i][i] = 1; // Single character is a palindrome
    }

    for (int len = 2; len <= N; ++len) {
        for (int i = 0; i <= N - len; ++i) {
            int j = i + len - 1;

            if (s[i] != s[j]) {
                dp[i][j] = (dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + MOD) % MOD;
            } else { // s[i] == s[j]
                int l = next_char_occurrence[i]; // Next occurrence of s[i] after i
                int r = prev_char_occurrence[j]; // Previous occurrence of s[j] before j

                if (l == -1 || r == -1 || l > r) {
                    // Case 1: No occurrences of s[i] strictly between i and j
                    // e.g., "aba" for s[0] and s[2]. Substring s[1...1] is 'b'.
                    // Palindromes are:
                    //  - s[i] (e.g., 'a')
                    //  - s[i]s[j] (e.g., 'aa')
                    //  - P (palindromes from s[i+1...j-1])
                    //  - s[i] P s[j] (palindromes from s[i+1...j-1] wrapped by s[i] and s[j])
                    // Total: 2 * dp[i+1][j-1] + 2
                    dp[i][j] = (2 * dp[i+1][j-1] + 2) % MOD;
                } else if (l == r) {
                    // Case 2: Exactly one occurrence of s[i] strictly between i and j
                    // e.g., "aaa" for s[0] and s[2]. Substring s[1...1] is 'a'.
                    // The formula `2 * dp[i+1][j-1] + 2` would overcount the single character 'a'.
                    // 'a' is counted as `s[i]` and also as `P` from `dp[i+1][j-1]`.
                    // So we subtract 1.
                    // Total: 2 * dp[i+1][j-1] + 1
                    dp[i][j] = (2 * dp[i+1][j-1] + 1) % MOD;
                } else { // l < r
                    // Case 3: Multiple occurrences of s[i] strictly between i and j
                    // e.g., "aabbaa" for s[0] and s[5]. s[1] and s[4] are the 'a's.
                    // The formula `2 * dp[i+1][j-1] + 2` overcounts palindromes of the form
                    // `s[i] Q s[j]` where `Q` is a palindrome from `s[l+1...r-1]`.
                    // These `Q` are counted as part of `dp[i+1][j-1]` (as `P`)
                    // and also as `s[i] P s[j]` (when `P` is `Q`).
                    // So we subtract `dp[l+1][r-1]` to correct for this overcounting.
                    dp[i][j] = (2 * dp[i+1][j-1] - dp[l+1][r-1] + MOD) % MOD;
                }
            }
        }
    }

    long long result = dp[0][N-1];

    // Free allocated memory
    for (int i = 0; i < N; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(next_char_occurrence);
    free(prev_char_occurrence);

    return (int)result;
}