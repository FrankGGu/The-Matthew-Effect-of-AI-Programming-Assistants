#include <string.h>
#include <stdlib.h>
#include <limits.h>

int calculate_semi_palindrome_cost(const char *s, int start, int end) {
    int current_cost = 0;
    int len = end - start + 1;

    // For i from 0 to len/2 - 1
    for (int i = 0; i < len / 2; ++i) {
        char char_left = s[start + i];
        char char_right_1 = s[end - i];
        char char_right_2 = s[end - 1 - i];

        // According to the definition: t[i] == t[len(t) - 1 - i] OR t[i] == t[len(t) - 2 - i]
        // If neither condition is met, a change is needed.
        if (char_left != char_right_1 && char_left != char_right_2) {
            current_cost++;
        }
    }
    return current_cost;
}

int minimumChanges(char *s, int k) {
    int n = strlen(s);

    // Precompute costs for all possible substrings s[i...j]
    // char_costs[i][j] stores the minimum changes for s[i...j] to be a semi-palindrome
    int **char_costs = (int **)malloc(n * sizeof(int *));
    for (int i = 0; i < n; ++i) {
        char_costs[i] = (int *)malloc(n * sizeof(int));
    }

    for (int i = 0; i < n; ++i) {
        for (int j = i; j < n; ++j) {
            char_costs[i][j] = calculate_semi_palindrome_cost(s, i, j);
        }
    }

    // dp[i][j] = minimum changes to partition s[0...i-1] into j semi-palindromes
    // i goes from 0 to n (exclusive end index of prefix), j goes from 0 to k (number of partitions)
    int **dp = (int **)malloc((n + 1) * sizeof(int *));
    for (int i = 0; i <= n; ++i) {
        dp[i] = (int *)malloc((k + 1) * sizeof(int));
        for (int j = 0; j <= k; ++j) {
            dp[i][j] = INT_MAX; // Initialize with a large value representing infinity
        }
    }

    // Base case: 0 changes for an empty prefix partitioned into 0 semi-palindromes
    dp[0][0] = 0;

    // Fill the DP table
    for (int num_parts = 1; num_parts <= k; ++num_parts) {
        for (int i = 1; i <= n; ++i) { // Current end index (exclusive) of the string prefix s[0...i-1]
            // Iterate over all possible previous split points 'prev_i'
            // 'prev_i' is the exclusive end index of the previous partition,
            // and the inclusive start index of the current partition.
            for (int prev_i = 0; prev_i < i; ++prev_i) {
                // If dp[prev_i][num_parts-1] is reachable (not INT_MAX)
                if (dp[prev_i][num_parts - 1] != INT_MAX) {
                    // The current substring being considered is s[prev_i ... i-1]
                    int current_segment_cost = char_costs[prev_i][i - 1];

                    // Update dp[i][num_parts] with the minimum cost
                    if (dp[prev_i][num_parts - 1] + current_segment_cost < dp[i][num_parts]) {
                        dp[i][num_parts] = dp[prev_i][num_parts - 1] + current_segment_cost;
                    }
                }
            }
        }
    }

    int result = dp[n][k];

    // Free allocated memory
    for (int i = 0; i < n; ++i) {
        free(char_costs[i]);
    }
    free(char_costs);

    for (int i = 0; i <= n; ++i) {
        free(dp[i]);
    }
    free(dp);

    return result;
}