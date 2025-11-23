import java.util.Arrays;

class Solution {
    public int mergeStones(int[] stones, int K) {
        int n = stones.length;

        // If it's impossible to merge all stones into one pile, return -1.
        // Each merge operation reduces the number of piles by (K - 1).
        // To merge N piles into 1 pile, we need to reduce (N - 1) piles.
        // Thus, (N - 1) must be divisible by (K - 1).
        if ((n - 1) % (K - 1) != 0) {
            return -1;
        }

        // Calculate prefix sums to quickly get the sum of stones in a range.
        // prefixSum[i] stores the sum of stones from index 0 to i-1.
        int[] prefixSum = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        // dp[i][j][k] stores the minimum cost to merge stones from index i to j into k piles.
        int[][][] dp = new int[n][n][K + 1];

        // Initialize dp array with a large value (infinity) to represent impossible states.
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(dp[i][j], Integer.MAX_VALUE);
            }
        }

        // Base case: merging a single stone (length 1) into 1 pile costs 0.
        for (int i = 0; i < n; i++) {
            dp[i][i][1] = 0;
        }

        // Iterate over the length of the subarray (len)
        for (int len = 2; len <= n; len++) {
            // Iterate over the starting index (i) of the subarray
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1; // Calculate the ending index (j)

                // Try to merge stones[i...j] into 'k' piles (where k ranges from 2 to K)
                for (int k = 2; k <= K; k++) {
                    // Split the subarray [i, j] at 'mid'.
                    // Merge stones[i...mid] into 1 pile and stones[mid+1...j] into (k-1) piles.
                    // The split point 'mid' must allow stones[i...mid] to be merged into 1 pile.
                    // This means (mid - i) must be a multiple of (K - 1).
                    // So, mid can be i, i + (K-1), i + 2*(K-1), etc.
                    for (int mid = i; mid < j; mid += K - 1) {
                        if (dp[i][mid][1] != Integer.MAX_VALUE && dp[mid + 1][j][k - 1] != Integer.MAX_VALUE) {
                            dp[i][j][k] = Math.min(dp[i][j][k], dp[i][mid][1] + dp[mid + 1][j][k - 1]);
                        }
                    }
                }

                // If stones[i...j] can be merged into K piles,
                // we can then merge these K piles into a single pile.
                // This final merge adds a cost equal to the sum of stones in the range [i, j].
                // This step is only valid if (len - 1) is a multiple of (K - 1),
                // which ensures that it's possible to eventually reduce to 1 pile.
                if (dp[i][j][K] != Integer.MAX_VALUE) {
                    dp[i][j][1] = Math.min(dp[i][j][1], dp[i][j][K] + prefixSum[j + 1] - prefixSum[i]);
                }
            }
        }

        // The final answer is the minimum cost to merge all stones (from 0 to n-1) into 1 pile.
        // If it's still Integer.MAX_VALUE, it means it's impossible (though the initial check should catch this).
        if (dp[0][n - 1][1] == Integer.MAX_VALUE) {
            return -1;
        }
        return dp[0][n - 1][1];
    }
}