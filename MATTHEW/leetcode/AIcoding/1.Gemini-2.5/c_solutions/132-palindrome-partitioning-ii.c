#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

int minCut(char * s){
    int n = strlen(s);

    if (n == 0) {
        return 0;
    }

    // isPalindrome[i][j] will be true if s[i...j] is a palindrome
    bool **isPalindrome = (bool **)malloc(n * sizeof(bool *));
    for (int i = 0; i < n; i++) {
        isPalindrome[i] = (bool *)malloc(n * sizeof(bool));
        for (int j = 0; j < n; j++) {
            isPalindrome[i][j] = false; // Initialize all to false
        }
    }

    // Fill isPalindrome table using dynamic programming
    // Base cases: single characters and two-character palindromes
    for (int i = 0; i < n; i++) {
        isPalindrome[i][i] = true; // Single characters are palindromes
    }

    for (int i = 0; i < n - 1; i++) {
        if (s[i] == s[i+1]) {
            isPalindrome[i][i+1] = true; // Two identical characters form a palindrome
        }
    }

    // Fill for lengths >= 3
    for (int len = 3; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;
            // s[i...j] is a palindrome if s[i] == s[j] and s[i+1...j-1] is a palindrome
            if (s[i] == s[j] && isPalindrome[i+1][j-1]) {
                isPalindrome[i][j] = true;
            } else {
                isPalindrome[i][j] = false;
            }
        }
    }

    // dp[i] will store the minimum cuts needed for the prefix s[0...i-1]
    int *dp = (int *)malloc((n + 1) * sizeof(int));

    // Base case: dp[0] = 0 (empty string needs 0 cuts)
    dp[0] = 0;

    // Iterate for prefixes of length 1 to n
    for (int i = 1; i <= n; i++) {
        dp[i] = INT_MAX; // Initialize with a very large value

        // Iterate through all possible split points 'j' for the prefix s[0...i-1]
        // s[j...i-1] is the current substring being considered as the last palindrome
        for (int j = 0; j < i; j++) {
            if (isPalindrome[j][i-1]) { // If s[j...i-1] is a palindrome
                if (j == 0) {
                    // If the entire prefix s[0...i-1] is a palindrome, no cuts needed
                    dp[i] = 0;
                    break; // 0 is the minimum, no need to check further for this 'i'
                } else {
                    // The number of cuts is min cuts for s[0...j-1] + 1 (for the current cut)
                    dp[i] = (dp[i] < dp[j] + 1) ? dp[i] : (dp[j] + 1);
                }
            }
        }
    }

    int result = dp[n];

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(isPalindrome[i]);
    }
    free(isPalindrome);
    free(dp);

    return result;
}