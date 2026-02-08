#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

bool isMatch(char *s, char *p) {
    int m = strlen(s);
    int n = strlen(p);

    // dp[i][j] will be true if s[0...i-1] matches p[0...j-1]
    bool** dp = (bool**)malloc((m + 1) * sizeof(bool*));
    for (int i = 0; i <= m; i++) {
        dp[i] = (bool*)malloc((n + 1) * sizeof(bool));
        // Initialize all dp table entries to false
        for (int j = 0; j <= n; j++) {
            dp[i][j] = false;
        }
    }

    // Base case: empty string matches empty pattern
    dp[0][0] = true;

    // Fill dp[0][j] for j > 0 (empty string s matches pattern p)
    // This handles patterns like "a*", "a*b*", etc. matching an empty string
    for (int j = 1; j <= n; j++) {
        // If p[j-1] is '*', it can match 0 occurrences of the preceding element (p[j-2])
        // So, s (empty) matches p[0...j-1] if s (empty) matches p[0...j-3]
        if (p[j-1] == '*') {
            dp[0][j] = dp[0][j-2];
        }
    }

    // Fill the rest of the dp table
    for (int i = 1; i <= m; i++) {
        for (int j = 1; j <= n; j++) {
            if (p[j-1] == '*') {
                // Case 1: p[j-1] is '*'
                // Option A: The '*' matches 0 occurrences of the preceding element (p[j-2])
                // In this case, s[0...i-1] needs to match p[0...j-3]
                bool match_zero_occurrences = dp[i][j-2];

                // Option B: The '*' matches 1 or more occurrences of the preceding element (p[j-2])
                // First, check if s[i-1] matches p[j-2] (or p[j-2] is '.')
                bool current_s_char_matches_prev_p_char = (s[i-1] == p[j-2] || p[j-2] == '.');
                // If s[i-1] matches p[j-2], then s[0...i-2] must match p[0...j-1]
                // (where p[0...j-1] still includes the '*' to potentially match more of s)
                bool match_one_or_more_occurrences = current_s_char_matches_prev_p_char && dp[i-1][j];

                dp[i][j] = match_zero_occurrences || match_one_or_more_occurrences;
            } else {
                // Case 2: p[j-1] is not '*'
                // s[i-1] must match p[j-1] (or p[j-1] is '.')
                bool current_chars_match = (s[i-1] == p[j-1] || p[j-1] == '.');
                // If they match, then s[0...i-2] must match p[0...j-2]
                dp[i][j] = current_chars_match && dp[i-1][j-1];
            }
        }
    }

    bool result = dp[m][n];

    // Free allocated memory
    for (int i = 0; i <= m; i++) {
        free(dp[i]);
    }
    free(dp);

    return result;
}