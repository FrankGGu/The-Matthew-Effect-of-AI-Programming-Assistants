#include <string.h> // For strlen
#include <stdlib.h> // For malloc, free

static inline int min(int a, int b) {
    return a < b ? a : b;
}

int minimumWhiteTiles(char *floor, int numCarpets, int carpetLen) {
    int n = strlen(floor);

    // prefix_white[k] stores the count of '1's in floor[0...k-1]
    // Size n+1 to store sums up to index n-1 (i.e., prefix_white[n])
    int *prefix_white = (int *)malloc((n + 1) * sizeof(int));

    prefix_white[0] = 0;
    for (int i = 0; i < n; i++) {
        prefix_white[i + 1] = prefix_white[i] + (floor[i] == '1' ? 1 : 0);
    }

    // dp arrays for space optimization
    // prev_dp stores results for j-1 carpets
    // curr_dp stores results for j carpets
    // Each array needs to store n+1 values (for indices 0 to n)
    int *prev_dp = (int *)malloc((n + 1) * sizeof(int));
    int *curr_dp = (int *)malloc((n + 1) * sizeof(int));

    // Initialize prev_dp for j=0 carpets
    // If no carpets are used, all white tiles up to index i-1 remain uncovered.
    for (int i = 0; i <= n; i++) {
        prev_dp[i] = prefix_white[i];
    }

    // Iterate through the number of carpets from 1 up to numCarpets
    for (int j = 1; j <= numCarpets; j++) {
        // Base case for curr_dp: 0 tiles considered, 0 white tiles remaining.
        curr_dp[0] = 0;

        // Iterate through the floor tiles from 1 to n (representing floor[0] to floor[n-1])
        for (int i = 1; i <= n; i++) {
            // Option 1: Do not place a carpet ending at floor[i-1].
            // The number of remaining white tiles is the same as for i-1 tiles with j carpets,
            // plus 1 if floor[i-1] is a white tile ('1'), otherwise 0.
            curr_dp[i] = curr_dp[i - 1] + (floor[i - 1] == '1' ? 1 : 0);

            // Option 2: Place a carpet ending at floor[i-1].
            // This carpet covers `carpetLen` tiles, from floor[i - carpetLen] to floor[i-1].
            // This option is only possible if there are at least `carpetLen` tiles to cover.
            if (i >= carpetLen) {
                // If we place a carpet, all white tiles within its length are covered.
                // The number of remaining white tiles is then determined by the state
                // before this carpet started (i.e., at index i - carpetLen) using one less carpet (j-1).
                curr_dp[i] = min(curr_dp[i], prev_dp[i - carpetLen]);
            }
        }

        // Swap prev_dp and curr_dp pointers for the next iteration.
        // The current curr_dp becomes the prev_dp for the next carpet count.
        int *temp = prev_dp;
        prev_dp = curr_dp;
        curr_dp = temp;
    }

    // The final answer is in prev_dp[n] because after the loop, prev_dp holds the results
    // for `numCarpets` (the last `j` value).
    int result = prev_dp[n];

    // Free dynamically allocated memory
    free(prefix_white);
    free(prev_dp); // prev_dp now points to the final result array
    free(curr_dp); // curr_dp points to the array that was prev_dp before the last swap

    return result;
}