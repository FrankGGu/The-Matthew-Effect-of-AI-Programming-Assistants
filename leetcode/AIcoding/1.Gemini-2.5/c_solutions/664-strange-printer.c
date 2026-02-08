#include <string.h>
#include <stdlib.h>
#include <math.h> // For fmin

int strangePrinter(char * s){
    int n = strlen(s);
    if (n == 0) {
        return 0;
    }

    // dp[i][j] stores the minimum turns to print substring s[i...j]
    // dp table size (n x n)
    int** dp = (int**) malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*) malloc(n * sizeof(int));
    }

    // Base cases:
    // For length 1, dp[i][i] = 1 (a single character takes 1 turn)
    for (int i = 0; i < n; i++) {
        dp[i][i] = 1;
    }

    // Fill dp table for lengths from 2 to n
    for (int len = 2; len <= n; len++) {
        for (int i = 0; i <= n - len; i++) {
            int j = i + len - 1;

            // Option 1: Print s[i] in a new turn, then solve for the remaining substring s[i+1...j].
            // This is always a valid option and provides an upper bound.
            dp[i][j] = 1 + dp[i+1][j];

            // Option 2: Find a k (from i+1 to j) such that s[k] == s[i].
            // If s[i] and s[k] are the same, the turn that prints s[i] can be extended to cover s[k].
            // In this case, we can break the problem into two subproblems:
            // 1. Print s[i...k-1]: This takes dp[i][k-1] turns. This segment includes s[i].
            // 2. Print s[k+1...j]: This takes dp[k+1][j] turns. s[k] is covered by s[i]'s turn.
            for (int k = i + 1; k <= j; k++) {
                if (s[i] == s[k]) {
                    // Calculate dp[k+1][j]. If k+1 > j, it means the range is empty, so cost is 0.
                    int cost_k_plus_1_j = 0;
                    if (k + 1 <= j) {
                        cost_k_plus_1_j = dp[k+1][j];
                    }
                    // Update dp[i][j] with the minimum of current value and this new option.
                    // dp[i][k-1] is always a valid range because k >= i+1 implies k-1 >= i.
                    dp[i][j] = fmin(dp[i][j], dp[i][k-1] + cost_k_plus_1_j);
                }
            }
        }
    }

    int result = dp[0][n-1];

    // Free allocated memory
    for (int i = 0; i < n; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}