#include <stdbool.h>
#include <string.h>

bool isInterleave(char * s1, char * s2, char * s3) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int len3 = strlen(s3);

    if (len1 + len2 != len3) {
        return false;
    }

    // dp[i][j] will be true if s3[0...i+j-1] is an interleaving of s1[0...i-1] and s2[0...j-1]
    bool dp[len1 + 1][len2 + 1];

    // Base case: empty s1 and empty s2 can form empty s3
    dp[0][0] = true;

    // Initialize the first column (s1 with empty s2)
    // dp[i][0] means s3[0...i-1] is formed by s1[0...i-1] and empty s2
    for (int i = 1; i <= len1; i++) {
        dp[i][0] = dp[i-1][0] && (s1[i-1] == s3[i-1]);
    }

    // Initialize the first row (s2 with empty s1)
    // dp[0][j] means s3[0...j-1] is formed by empty s1 and s2[0...j-1]
    for (int j = 1; j <= len2; j++) {
        dp[0][j] = dp[0][j-1] && (s2[j-1] == s3[j-1]);
    }

    // Fill the rest of the DP table
    for (int i = 1; i <= len1; i++) {
        for (int j = 1; j <= len2; j++) {
            // Check if s3[i+j-1] matches s1[i-1] AND the prefix dp[i-1][j] was true
            bool from_s1 = dp[i-1][j] && (s1[i-1] == s3[i+j-1]);

            // Check if s3[i+j-1] matches s2[j-1] AND the prefix dp[i][j-1] was true
            bool from_s2 = dp[i][j-1] && (s2[j-1] == s3[i+j-1]);

            dp[i][j] = from_s1 || from_s2;
        }
    }

    // The final result is whether s3 (length len1+len2) can be formed by s1 (length len1) and s2 (length len2)
    return dp[len1][len2];
}