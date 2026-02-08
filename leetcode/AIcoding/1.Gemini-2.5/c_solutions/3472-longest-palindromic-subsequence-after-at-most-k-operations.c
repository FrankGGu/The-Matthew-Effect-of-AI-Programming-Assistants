#include <string.h>
#include <stdlib.h> // For malloc, calloc, free

#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

int longestPalindromeSubsequence(char * s, int k){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    // dp[i][j][ops] stores the maximum length of a palindromic subsequence
    // for substring s[i...j] using exactly 'ops' operations.
    // Dimensions: n x n x (k + 1)
    int*** dp = (int***) malloc(n * sizeof(int**));
    for (int i = 0; i < n; i++) {
        dp[i] = (int**) malloc(n * sizeof(int*));
        for (int j = 0; j < n; j++) {
            // calloc initializes memory to zero.
            // dp[i+1][j-1][ops] for empty ranges (i+1 > j-1) will implicitly be 0.
            dp[i][j] = (int*) calloc(k + 1, sizeof(int));
        }
    }

    // Base cases: single characters are palindromes of length 1, using 0 operations.
    // For s[i...i], length is 1.
    for (int i = 0; i < n; i++) {
        dp[i][i][0] = 1;
    }

    // Fill the DP table
    // len is the length of the current substring (j - i + 1)
    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            for (int ops = 0; ops <= k; ops++) {
                // Option 1: s[i] and s[j] form a pair
                if (s[i] == s[j]) {
                    // Match s[i] and s[j] without using an operation
                    // Add 2 to the length of the palindrome from the inner substring s[i+1...j-1]
                    dp[i][j][ops] = MAX(dp[i][j][ops], 2 + dp[i+1][j-1][ops]);
                } else { // s[i] != s[j]
                    if (ops > 0) { // We can use one operation to make them match
                        // Add 2 to the length of the palindrome from the inner substring s[i+1...j-1]
                        // and decrement the available operations.
                        dp[i][j][ops] = MAX(dp[i][j][ops], 2 + dp[i+1][j-1][ops-1]);
                    }
                }

                // Option 2: s[i] is not part of the palindrome (consider s[i+1...j])
                dp[i][j][ops] = MAX(dp[i][j][ops], dp[i+1][j][ops]);

                // Option 3: s[j] is not part of the palindrome (consider s[i...j-1])
                dp[i][j][ops] = MAX(dp[i][j][ops], dp[i][j-1][ops]);
            }
        }
    }

    // The result is the maximum length found for the entire string s[0...n-1]
    // using at most k operations.
    int max_overall_len = 0;
    // Iterate through all possible operations used, from 0 to k
    for (int ops_used = 0; ops_used <= k; ops_used++) {
        max_overall_len = MAX(max_overall_len, dp[0][n-1][ops_used]);
    }

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);

    return max_overall_len;
}