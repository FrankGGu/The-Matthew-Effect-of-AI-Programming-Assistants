#include <stdlib.h> // For qsort, malloc, free
#include <limits.h> // For LLONG_MAX

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minCost(int n, int* cuts, int cutsSize) {
    // Create an extended cuts array: [0, cuts[0], ..., cuts[cutsSize-1], n]
    // These represent the start and end of the stick, and all given cut points.
    int extendedCutsSize = cutsSize + 2;
    int* extendedCuts = (int*)malloc(extendedCutsSize * sizeof(int));
    extendedCuts[0] = 0;
    for (int i = 0; i < cutsSize; ++i) {
        extendedCuts[i + 1] = cuts[i];
    }
    extendedCuts[extendedCutsSize - 1] = n;

    // Sort the extended cuts array to ensure points are in increasing order.
    qsort(extendedCuts, extendedCutsSize, sizeof(int), compare);

    // Initialize a 2D DP table.
    // dp[i][j] will store the minimum cost to cut the stick segment
    // from extendedCuts[i] to extendedCuts[j].
    // Using long long for the DP table to prevent potential overflow,
    // as intermediate costs can exceed INT_MAX given n up to 10^9 and cutsSize up to 100.
    // The final result will be cast to int as per the function signature,
    // assuming the problem guarantees the ultimate minimum cost fits in int.
    long long** dp = (long long**)malloc(extendedCutsSize * sizeof(long long*));
    for (int i = 0; i < extendedCutsSize; ++i) {
        dp[i] = (long long*)malloc(extendedCutsSize * sizeof(long long));
        for (int j = 0; j < extendedCutsSize; ++j) {
            dp[i][j] = LLONG_MAX; // Initialize with a very large value (infinity)
        }
    }

    // Base cases: A segment between two adjacent cut points (length 1 in terms of indices)
    // requires no further cuts, so the cost is 0.
    for (int i = 0; i < extendedCutsSize - 1; ++i) {
        dp[i][i+1] = 0;
    }

    // Fill the DP table using a bottom-up approach.
    // 'len' represents the number of intervals (or segments) between the start and end indices.
    // A segment from extendedCuts[i] to extendedCuts[j] has (j - i) intervals.
    // We start with segments of 2 intervals (e.g., [i, i+2]) and go up to the full stick.
    for (int len = 2; len < extendedCutsSize; ++len) {
        // 'i' is the starting index of the current stick segment.
        for (int i = 0; i < extendedCutsSize - len; ++i) {
            // 'j' is the ending index of the current stick segment.
            int j = i + len;

            // The cost of making a cut is the current length of the stick segment being cut.
            long long currentSegmentLength = extendedCuts[j] - extendedCuts[i];

            // Iterate through all possible intermediate cut points 'k' within the segment [i, j].
            for (int k = i + 1; k < j; ++k) {
                // Only consider valid subproblem costs (not infinity).
                if (dp[i][k] != LLONG_MAX && dp[k][j] != LLONG_MAX) {
                    // The total cost for this path is the current segment length plus
                    // the minimum costs of cutting the two sub-segments.
                    long long currentTotalCost = currentSegmentLength + dp[i][k] + dp[k][j];

                    // Update dp[i][j] if this path yields a smaller total cost.
                    if (currentTotalCost < dp[i][j]) {
                        dp[i][j] = currentTotalCost;
                    }
                }
            }
        }
    }

    // The result is the minimum cost to cut the entire stick,
    // which corresponds to the segment from extendedCuts[0] to extendedCuts[extendedCutsSize - 1].
    long long result_ll = dp[0][extendedCutsSize - 1];

    // Free allocated memory
    for (int i = 0; i < extendedCutsSize; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(extendedCuts);

    // Cast the result to int as required by the function signature.
    // This implicitly assumes the final minimum cost will fit within an int.
    return (int)result_ll;
}