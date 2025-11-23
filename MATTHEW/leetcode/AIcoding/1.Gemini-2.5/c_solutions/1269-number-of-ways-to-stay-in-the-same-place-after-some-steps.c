#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

int numWays(int steps, int arrLen) {
    int MOD = 1000000007;

    // The maximum index we need to consider is min(steps / 2, arrLen - 1).
    // This is because to return to index 0, for every right move, there must be a left move.
    // So, if we reach index k, we need at least k right moves and k left moves.
    // Total steps = 2k + (stay moves). So 2k <= steps => k <= steps / 2.
    // Also, the index k cannot exceed arrLen - 1.
    // So, the maximum relevant index is min(steps / 2, arrLen - 1).

    // Let's calculate the maximum index that is relevant for our DP table.
    int max_relevant_idx = steps / 2;

    // This maximum index also cannot exceed arrLen - 1.
    if (max_relevant_idx >= arrLen) {
        max_relevant_idx = arrLen - 1;
    }

    // The DP array size will be max_relevant_idx + 1.
    // Example: if max_relevant_idx is 0, size is 1 (for index 0).
    // Example: if max_relevant_idx is 1, size is 2 (for indices 0, 1).
    int dp_array_size = max_relevant_idx + 1;

    // dp_prev[j] stores the number of ways to be at index j after (s-1) steps.
    // dp_curr[j] stores the number of ways to be at index j after s steps.
    int* dp_prev = (int*)calloc(dp_array_size, sizeof(int));
    int* dp_curr = (int*)calloc(dp_array_size, sizeof(int));

    // Base case: After 0 steps, there is 1 way to be at index 0.
    dp_prev[0] = 1;

    for (int s = 1; s <= steps; s++) {
        // Reset dp_curr for the current step
        memset(dp_curr, 0, dp_array_size * sizeof(int));

        // Iterate through all relevant positions
        // The loop upper bound for j is dp_array_size - 1.
        // Any position beyond s is unreachable in s steps, so dp_prev[j] would be 0 anyway.
        // Any position beyond arrLen-1 is invalid.
        // Any position beyond max_relevant_idx is not useful for returning to 0.
        // So, iterating up to dp_array_size - 1 is sufficient and correct.
        for (int j = 0; j < dp_array_size; j++) {
            // Option 1: Stay at current position j
            dp_curr[j] = dp_prev[j];

            // Option 2: Move right to j from j-1
            if (j > 0) {
                dp_curr[j] = (dp_curr[j] + dp_prev[j-1]) % MOD;
            }

            // Option 3: Move left to j from j+1
            // j+1 must be a valid index within our DP array (i.e., less than dp_array_size).
            if (j < dp_array_size - 1) { 
                dp_curr[j] = (dp_curr[j] + dp_prev[j+1]) % MOD;
            }
        }

        // Swap dp_prev and dp_curr for the next iteration
        int* temp = dp_prev;
        dp_prev = dp_curr;
        dp_curr = temp;
    }

    // The result is the number of ways to be at index 0 after 'steps' steps.
    int result = dp_prev[0];

    // Free allocated memory
    free(dp_prev);
    free(dp_curr); // dp_curr now points to the array that was originally dp_prev

    return result;
}