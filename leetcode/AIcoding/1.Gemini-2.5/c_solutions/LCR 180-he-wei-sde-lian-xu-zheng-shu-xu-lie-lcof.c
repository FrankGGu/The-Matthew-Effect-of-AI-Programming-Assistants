#include <limits.h> // For LLONG_MAX
#include <stdlib.h> // For malloc, free

long long min_ll(long long a, long long b) {
    return a < b ? a : b;
}

int mergeFiles(int* files, int filesSize) {
    // If there are 0 or 1 files, no merging is needed, so the cost is 0.
    if (filesSize <= 1) {
        return 0;
    }

    // 1. Precompute prefix sums to quickly get the sum of elements in a range.
    // prefixSum[p] stores the sum of files[0]...files[p-1].
    // The array will have filesSize + 1 elements, where prefixSum[0] is 0.
    long long* prefixSum = (long long*)malloc((filesSize + 1) * sizeof(long long));
    prefixSum[0] = 0;
    for (int i = 0; i < filesSize; ++i) {
        prefixSum[i + 1] = prefixSum[i] + files[i];
    }

    // 2. Initialize the DP table.
    // dp[i][j] will store the minimum cost to merge files from index i to j (inclusive).
    // The table size is filesSize x filesSize.
    long long** dp = (long long**)malloc(filesSize * sizeof(long long*));
    for (int i = 0; i < filesSize; ++i) {
        dp[i] = (long long*)malloc(filesSize * sizeof(long long));
        for (int j = 0; j < filesSize; ++j) {
            if (i == j) {
                dp[i][j] = 0; // Cost to merge a single file is 0.
            } else {
                dp[i][j] = LLONG_MAX; // Initialize with a very large value (infinity).
            }
        }
    }

    // 3. Fill the DP table using a bottom-up approach.
    // 'len' represents the length of the subarray (number of files) being merged.
    for (int len = 2; len <= filesSize; ++len) {
        // 'i' is the starting index of the current subarray.
        for (int i = 0; i <= filesSize - len; ++i) {
            // 'j' is the ending index of the current subarray.
            int j = i + len - 1;

            // The cost incurred for the final merge of the subarray files[i...j]
            // is the sum of all files within this range. This sum is added once
            // when the entire segment [i, j] is finally merged into a single pile.
            long long current_segment_sum = prefixSum[j + 1] - prefixSum[i];

            // 'k' is the split point, dividing the subarray [i, j] into two parts:
            // [i, k] and [k+1, j]. We try all possible split points.
            for (int k = i; k < j; ++k) {
                // Ensure that the subproblems (merging [i, k] and [k+1, j])
                // have valid solutions (i.e., not LLONG_MAX, which implies they couldn't be merged).
                if (dp[i][k] != LLONG_MAX && dp[k + 1][j] != LLONG_MAX) {
                    // The total cost for merging files[i...j] via split point k is:
                    // cost to merge [i, k] + cost to merge [k+1, j] + cost of the final merge (current_segment_sum).
                    dp[i][j] = min_ll(dp[i][j], dp[i][k] + dp[k + 1][j] + current_segment_sum);
                }
            }
        }
    }

    // The result is the minimum cost to merge all files from index 0 to filesSize - 1.
    long long result = dp[0][filesSize - 1];

    // 4. Free allocated memory to prevent memory leaks.
    for (int i = 0; i < filesSize; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(prefixSum);

    // The problem typically expects an int return type.
    // If the actual result could exceed INT_MAX, the return type might need to be long long.
    return (int)result;
}