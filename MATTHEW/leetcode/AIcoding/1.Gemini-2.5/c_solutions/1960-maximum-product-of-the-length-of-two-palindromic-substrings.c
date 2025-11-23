#include <string.h>
#include <stdbool.h>
#include <stdlib.h> // For malloc, free

int max(int a, int b) {
    return a > b ? a : b;
}

long long maxProduct(char* s) {
    int n = strlen(s);

    // dp[i][j] will be true if s[i...j] is a palindrome
    // Using char instead of bool to potentially save some memory, though bool is fine.
    // 2D array allocation
    char** dp = (char**)malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) {
        dp[i] = (char*)malloc(n * sizeof(char));
        for (int j = 0; j < n; j++) {
            dp[i][j] = 0; // Initialize to false
        }
    }

    // All single characters are palindromes
    for (int i = 0; i < n; i++) {
        dp[i][i] = 1; // true
    }

    // Check for palindromes of length 2
    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i+1]) {
            dp[i][i+1] = 1; // true
        }
    }

    // Check for palindromes of length 3 or more
    // len is the length of the substring
    for (int len = 3; len <= n; len++) {
        // i is the starting index
        for (int i = 0; i <= n - len; i++) {
            // j is the ending index
            int j = i + len - 1;
            // If characters at ends match and the inner substring is a palindrome
            if (s[i] == s[j] && dp[i+1][j-1]) {
                dp[i][j] = 1; // true
            }
        }
    }

    // max_len_prefix[k] stores the maximum length of a palindromic substring
    // that is entirely contained within s[0...k]
    int* max_len_prefix = (int*)malloc(n * sizeof(int));
    max_len_prefix[0] = 1; // s[0] is a palindrome of length 1
    for (int k = 1; k < n; k++) {
        max_len_prefix[k] = max_len_prefix[k-1]; // Inherit from previous prefix
        for (int i = 0; i <= k; i++) {
            if (dp[i][k]) { // If s[i...k] is a palindrome
                max_len_prefix[k] = max(max_len_prefix[k], k - i + 1);
            }
        }
    }

    // max_len_suffix[k] stores the maximum length of a palindromic substring
    // that is entirely contained within s[k...n-1]
    int* max_len_suffix = (int*)malloc(n * sizeof(int));
    max_len_suffix[n-1] = 1; // s[n-1] is a palindrome of length 1
    for (int k = n - 2; k >= 0; k--) {
        max_len_suffix[k] = max_len_suffix[k+1]; // Inherit from next suffix
        for (int j = k; j < n; j++) {
            if (dp[k][j]) { // If s[k...j] is a palindrome
                max_len_suffix[k] = max(max_len_suffix[k], j - k + 1);
            }
        }
    }

    long long max_prod = 0;
    // Iterate through all possible split points
    // A split point `k` means the first palindrome is in s[0...k]
    // and the second palindrome is in s[k+1...n-1].
    // The two palindromes are guaranteed to be non-overlapping by this split.
    for (int k = 0; k < n - 1; k++) {
        long long current_prod = (long long)max_len_prefix[k] * max_len_suffix[k+1];
        if (current_prod > max_prod) {
            max_prod = current_prod;
        }
    }

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(max_len_prefix);
    free(max_len_suffix);

    return max_prod;
}