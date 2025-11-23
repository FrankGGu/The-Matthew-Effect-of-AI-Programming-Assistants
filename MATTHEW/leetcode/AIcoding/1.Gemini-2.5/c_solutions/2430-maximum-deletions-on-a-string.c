#include <string.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int longestDecomposition(char * s) {
    int n = strlen(s);

    // dp[i] stores the maximum number of operations for the suffix s[i...]
    // Size n+1 to handle dp[n] (empty suffix)
    int* dp = (int*)malloc((n + 1) * sizeof(int));
    if (!dp) return 0; // Handle allocation failure

    // lcp[i][j] stores the length of the longest common prefix of s[i...] and s[j...]
    // Size (n+1) x (n+1)
    int** lcp = (int**)malloc((n + 1) * sizeof(int*));
    if (!lcp) {
        free(dp);
        return 0;
    }
    for (int i = 0; i <= n; ++i) {
        lcp[i] = (int*)malloc((n + 1) * sizeof(int));
        if (!lcp[i]) {
            // Clean up previously allocated memory in case of failure
            for (int k = 0; k < i; ++k) free(lcp[k]);
            free(lcp);
            free(dp);
            return 0;
        }
    }

    // Initialize lcp table for base cases (suffixes starting at or beyond n)
    for (int i = 0; i <= n; ++i) {
        lcp[i][n] = 0;
        lcp[n][i] = 0;
    }

    // Compute lcp table using dynamic programming
    // Iterate backwards to utilize previously computed values
    for (int i = n - 1; i >= 0; --i) {
        for (int j = n - 1; j >= 0; --j) {
            if (s[i] == s[j]) {
                lcp[i][j] = 1 + lcp[i+1][j+1];
            } else {
                lcp[i][j] = 0;
            }
        }
    }

    // Initialize dp table
    dp[n] = 0; // An empty string has 0 operations

    // Fill dp table from n-1 down to 0
    for (int i = n - 1; i >= 0; --i) {
        // Option 1: Always possible to delete the current character s[i]
        // This counts as 1 deletion, and we proceed with the rest of the string s[i+1...]
        dp[i] = 1 + dp[i+1];

        // Option 2: Find a prefix s[i...i+L-1] that matches s[i+L...i+2L-1]
        // If they match, we can delete the first L characters (s[i...i+L-1])
        // This counts as 1 deletion, and we proceed with the string s[i+L...]
        // The length L can range from 1 up to (n-i)/2
        for (int L = 1; i + 2 * L <= n; ++L) {
            // Check if s[i...i+L-1] is equal to s[i+L...i+2L-1]
            // This is true if the longest common prefix of s[i...] and s[i+L...] is at least L
            if (lcp[i][i+L] >= L) {
                dp[i] = max(dp[i], 1 + dp[i+L]);
            }
        }
    }

    int result = dp[0];

    // Free allocated memory
    free(dp);
    for (int i = 0; i <= n; ++i) {
        free(lcp[i]);
    }
    free(lcp);

    return result;
}