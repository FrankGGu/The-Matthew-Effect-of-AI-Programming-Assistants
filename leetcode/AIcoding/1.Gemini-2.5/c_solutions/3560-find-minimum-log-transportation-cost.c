#include <limits.h> // For INT_MAX
#include <stdlib.h> // For malloc, free

static int min(int a, int b) {
    return a < b ? a : b;
}

int findMinimumLogTransportationCost(int* logs, int logsSize) {
    if (logsSize <= 1) {
        return 0; // No cost to merge 0 or 1 log
    }

    // Calculate prefix sums for efficient sum calculation of sub-arrays
    // prefixSum[i] stores the sum of logs[0]...logs[i-1]
    int* prefixSum = (int*)malloc((logsSize + 1) * sizeof(int));
    if (prefixSum == NULL) {
        return -1; // Memory allocation failed
    }
    prefixSum[0] = 0;
    for (int i = 0; i < logsSize; ++i) {
        prefixSum[i + 1] = prefixSum[i] + logs[i];
    }

    // dp[i][j] stores the minimum cost to merge logs from index i to j (inclusive)
    // Using a dynamically allocated 2D array to support variable logsSize.
    // The type `int (*)[logsSize]` makes `dp` a pointer to an array of `logsSize` integers,
    // allowing `dp[row][col]` syntax.
    int (*dp)[logsSize] = malloc(logsSize * sizeof(int[logsSize]));
    if (dp == NULL) {
        free(prefixSum);
        return -1; // Memory allocation failed
    }

    // Initialize dp table
    for (int i = 0; i < logsSize; ++i) {
        for (int j = 0; j < logsSize; ++j) {
            if (i == j) {
                dp[i][j] = 0; // Cost to merge a single log is 0
            } else {
                dp[i][j] = INT_MAX; // Initialize with a large value
            }
        }
    }

    // Iterate over the length of the sub-array (len)
    // len ranges from 2 (merging two logs) to logsSize (merging all logs)
    for (int len = 2; len <= logsSize; ++len) {
        // Iterate over the starting index (i) of the sub-array
        for (int i = 0; i <= logsSize - len; ++i) {
            // Calculate the ending index (j) of the sub-array
            int j = i + len - 1;

            // The cost of the final merge for logs[i...j] is their total sum
            // This sum is added to the minimum cost of merging its two sub-parts
            int current_merge_cost = prefixSum[j + 1] - prefixSum[i];

            // Iterate over all possible split points (k)
            // A split point k divides logs[i...j] into logs[i...k] and logs[k+1...j]
            for (int k = i; k < j; ++k) {
                // Ensure subproblems are reachable (not INT_MAX) to prevent overflow
                if (dp[i][k] != INT_MAX && dp[k + 1][j] != INT_MAX) {
                    dp[i][j] = min(dp[i][j], dp[i][k] + dp[k + 1][j] + current_merge_cost);
                }
            }
        }
    }

    int result = dp[0][logsSize - 1];

    // Free allocated memory
    free(prefixSum);
    free(dp);

    return result;
}