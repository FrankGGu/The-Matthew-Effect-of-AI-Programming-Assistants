#include <string.h>
#include <stdlib.h>

int minimumDeleteSum(char * s1, char * s2){
    int len1 = strlen(s1);
    int len2 = strlen(s2);

    // dp[i][j] stores the minimum ASCII delete sum for s1[0...i-1] and s2[0...j-1]
    int **dp = (int **)malloc((len1 + 1) * sizeof(int *));
    for (int i = 0; i <= len1; i++) {
        dp[i] = (int *)malloc((len2 + 1) * sizeof(int));
    }

    // Initialize base case: empty strings have 0 delete sum
    dp[0][0] = 0;

    // Initialize first column: delete all characters of s1
    for (int i = 1; i <= len1; i++) {
        dp[i][0] = dp[i-1][0] + (int)s1[i-1];
    }

    // Initialize first row: delete all characters of s2
    for (int j = 1; j <= len2; j++) {
        dp[0][j] = dp[0][j-1] + (int)s2[j-1];
    }

    // Fill the DP table
    for (int i = 1; i <= len1; i++) {
        for (int j = 1; j <= len2; j++) {
            if (s1[i-1] == s2[j-1]) {
                // If characters match, no deletion needed for them
                dp[i][j] = dp[i-1][j-1];
            } else {
                // If characters don't match, we must delete one of them
                // Option 1: delete s1[i-1]
                // Option 2: delete s2[j-1]
                dp[i][j] = (dp[i-1][j] + (int)s1[i-1] < dp[i][j-1] + (int)s2[j-1]) ? 
                           (dp[i-1][j] + (int)s1[i-1]) : 
                           (dp[i][j-1] + (int)s2[j-1]);
            }
        }
    }

    int result = dp[len1][len2];

    // Free allocated memory
    for (int i = 0; i <= len1; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}