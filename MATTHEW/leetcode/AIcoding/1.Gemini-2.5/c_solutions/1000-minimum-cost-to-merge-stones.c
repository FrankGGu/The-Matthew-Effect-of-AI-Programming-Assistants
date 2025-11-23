#include <stdlib.h>
#include <limits.h>
#include <string.h> // For memset, though manual initialization is used here

static int min(int a, int b) {
    return (a < b) ? a : b;
}

int mergeStones(int* stones, int stonesSize, int K) {
    int n = stonesSize;

    if ((n - 1) % (K - 1) != 0) {
        return -1;
    }

    int* prefixSum = (int*)malloc((n + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < n; ++i) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    // Helper to get sum of stones[i...j]
    // (prefixSum[j + 1] - prefixSum[i])
    #define GET_SUM(i, j) (prefixSum[j + 1] - prefixSum[i])

    // dp[i][j][k] = minimum cost to merge stones[i...j] into k piles
    // Using dynamic allocation for a 3D array
    int*** dp = (int***)malloc(n * sizeof(int**));
    for (int i = 0; i < n; ++i) {
        dp[i] = (int**)malloc(n * sizeof(int*));
        for (int j = 0; j < n; ++j) {
            dp[i][j] = (int*)malloc((K + 1) * sizeof(int));
            for (int k_idx = 0; k_idx <= K; ++k_idx) {
                dp[i][j][k_idx] = 0x3f3f3f3f; // Represents infinity
            }
        }
    }

    // Base case: merging a single stone into 1 pile costs 0
    for (int i = 0; i < n; ++i) {
        dp[i][i][1] = 0;
    }

    // len: length of the subarray (from 2 to n)
    for (int len = 2; len <= n; ++len) {
        // i: start index of the subarray
        for (int i = 0; i <= n - len; ++i) {
            int j = i + len - 1; // j: end index of the subarray

            // Calculate dp[i][j][k] for k from 2 to K
            // This represents merging stones[i...j] into k piles
            for (int k = 2; k <= K; ++k) {
                // Conditions for forming k piles from 'len' stones:
                // 1. The number of piles 'k' cannot exceed the number of stones 'len'.
                // 2. Each merge operation reduces the number of piles by (K - 1).
                //    To go from 'len' individual stones to 'k' piles, we need to perform
                //    (len - k) / (K - 1) merges. This number must be an integer.
                if (k > len || (len - k) % (K - 1) != 0) {
                    continue; // Impossible to form 'k' piles from 'len' stones
                }

                // Iterate through all possible split points 'm'
                // We merge stones[i...m] into 1 pile and stones[m+1...j] into k-1 piles
                for (int m = i; m < j; ++m) {
                    if (dp[i][m][1] != 0x3f3f3f3f && dp[m+1][j][k-1] != 0x3f3f3f3f) {
                        dp[i][j][k] = min(dp[i][j][k], dp[i][m][1] + dp[m+1][j][k-1]);
                    }
                }
            }

            // After calculating dp[i][j][k] for k=2...K, now calculate dp[i][j][1]
            // This is possible only if we can merge 'len' stones into K piles,
            // and then merge those K piles into 1.
            // Condition for forming 1 pile from 'len' stones:
            // (len - 1) must be divisible by (K - 1)
            if ((len - 1) % (K - 1) == 0) {
                if (dp[i][j][K] != 0x3f3f3f3f) {
                    dp[i][j][1] = dp[i][j][K] + GET_SUM(i, j);
                }
            }
        }
    }

    int result = dp[0][n-1][1];

    // Free dynamically allocated memory
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            free(dp[i][j]);
        }
        free(dp[i]);
    }
    free(dp);
    free(prefixSum);

    return (result == 0x3f3f3f3f) ? -1 : result;
}