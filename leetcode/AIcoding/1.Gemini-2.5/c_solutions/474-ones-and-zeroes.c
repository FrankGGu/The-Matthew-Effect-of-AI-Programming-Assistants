#include <stdlib.h>
#include <string.h>
#include <math.h> // For fmax, though a ternary operator can also be used

int findMaxForm(char **strs, int strsSize, int m, int n) {
    // dp[i][j] stores the maximum number of strings that can be formed
    // using i zeros and j ones.
    int **dp = (int **)calloc(m + 1, sizeof(int *));
    for (int i = 0; i <= m; i++) {
        dp[i] = (int *)calloc(n + 1, sizeof(int));
    }

    for (int k = 0; k < strsSize; k++) {
        char *s = strs[k];
        int zeros = 0;
        int ones = 0;
        for (int char_idx = 0; s[char_idx] != '\0'; char_idx++) {
            if (s[char_idx] == '0') {
                zeros++;
            } else {
                ones++;
            }
        }

        // Iterate backwards to ensure each string is considered at most once
        // (0/1 knapsack property).
        for (int i = m; i >= zeros; i--) {
            for (int j = n; j >= ones; j--) {
                dp[i][j] = fmax(dp[i][j], 1 + dp[i - zeros][j - ones]);
            }
        }
    }

    int result = dp[m][n];

    // Free allocated memory
    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}