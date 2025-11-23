#include <string.h>
#include <stdlib.h>

#define MOD 1000000007

int numberOfWays(char **words, int wordsSize, char *target) {
    int n = strlen(target);
    int m = strlen(words[0]); // All words have the same length

    // freq[col][char_idx] stores count of char_idx ('a' to 'z') at 'col'
    int **freq = (int **)malloc(m * sizeof(int *));
    for (int i = 0; i < m; i++) {
        freq[i] = (int *)calloc(26, sizeof(int)); // Initialize with zeros
    }

    // Precompute frequencies of characters at each column
    for (int j = 0; j < m; j++) { // Iterate through columns
        for (int i = 0; i < wordsSize; i++) { // Iterate through words
            freq[j][words[i][j] - 'a']++;
        }
    }

    // dp[i][j] = number of ways to form target[0...i-1] using characters from columns 0...j-1
    long long **dp = (long long **)malloc((n + 1) * sizeof(long long *));
    for (int i = 0; i <= n; i++) {
        dp[i] = (long long *)calloc((m + 1), sizeof(long long)); // Initialize with zeros
    }

    // Base case: 1 way to form an empty target using 0 columns
    dp[0][0] = 1;

    for (int i = 0; i <= n; i++) { // Iterate through target prefix lengths (0 to n)
        for (int j = 1; j <= m; j++) { // Iterate through number of columns considered from words (1 to m)
            // Option 1: Don't use column j-1 to form target[0...i-1].
            // In this case, we form target[0...i-1] using columns 0...j-2.
            dp[i][j] = dp[i][j-1];

            // Option 2: Use column j-1 to match target[i-1].
            // This is only possible if target prefix length i > 0 (we need a character to match).
            if (i > 0) {
                int char_to_match_idx = target[i-1] - 'a';
                long long ways_to_match_char_at_col = freq[j-1][char_to_match_idx];

                // If there are ways to match target[i-1] at column j-1,
                // and ways to form target[0...i-2] using columns 0...j-2.
                if (ways_to_match_char_at_col > 0) {
                    dp[i][j] = (dp[i][j] + (dp[i-1][j-1] * ways_to_match_char_at_col) % MOD) % MOD;
                }
            }
        }
    }

    long long result = dp[n][m];

    // Free allocated memory
    for (int i = 0; i < m; i++) {
        free(freq[i]);
    }
    free(freq);

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return (int)result;
}