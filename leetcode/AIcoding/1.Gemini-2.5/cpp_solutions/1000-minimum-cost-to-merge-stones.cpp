#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int mergeStones(std::vector<int>& stones, int K) {
        int n = stones.size();

        // If it's impossible to merge all stones into one pile, return -1.
        // Each merge operation reduces the number of piles by (K - 1).
        // To go from n piles to 1 pile, we need to reduce n - 1 piles.
        // So, (n - 1) must be divisible by (K - 1).
        if ((n - 1) % (K - 1) != 0) {
            return -1;
        }

        // Calculate prefix sums for efficient sum calculation of stone ranges.
        std::vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + stones[i];
        }

        // dp[i][j][p] = minimum cost to merge stones from index i to j into p piles.
        // p can range from 1 to K.
        // Initialize with a large value (infinity) to represent unreachable states.
        const int INF = 1e9; // A sufficiently large value for infinity
        std::vector<std::vector<std::vector<int>>> dp(n, std::vector<std::vector<int>>(n, std::vector<int>(K + 1, INF)));

        // Base cases: merging a single stone into 1 pile costs 0.
        for (int i = 0; i < n; ++i) {
            dp[i][i][1] = 0;
        }

        // Iterate over interval lengths (len)
        // 'len' goes from 2 up to n (the entire array)
        for (int len = 2; len <= n; ++len) {
            // Iterate over starting indices (i) for the current length
            for (int i = 0; i <= n - len; ++i) {
                int j = i + len - 1; // Calculate the corresponding end index (j)

                // Calculate dp[i][j][p] for p from 2 to K.
                // These are intermediate merges where we reduce piles but not to 1.
                for (int p = 2; p <= K; ++p) {
                    // Check if it's possible to merge 'len' stones into 'p' piles.
                    // (len - p) must be non-negative and divisible by (K - 1).
                    if ((len - p) % (K - 1) != 0) {
                        continue; // This state is not reachable with valid merges
                    }

                    // To merge stones[i...j] into 'p' piles, we split it at 'mid'.
                    // Merge stones[i...mid] into 1 pile, and stones[mid+1...j] into p-1 piles.
                    for (int mid = i; mid < j; ++mid) {
                        if (dp[i][mid][1] != INF && dp[mid + 1][j][p - 1] != INF) {
                            dp[i][j][p] = std::min(dp[i][j][p], dp[i][mid][1] + dp[mid + 1][j][p - 1]);
                        }
                    }
                }

                // After calculating dp[i][j][p] for p from 2 to K,
                // calculate dp[i][j][1] (merging into a single pile).
                // This step requires merging K piles into 1. The cost for this final merge
                // is the sum of all stones in the interval [i...j].
                // This depends on dp[i][j][K] being already computed.
                if ((len - 1) % (K - 1) == 0) { // Check if it's possible to merge 'len' stones into 1 pile
                    if (dp[i][j][K] != INF) {
                        dp[i][j][1] = dp[i][j][K] + (prefixSum[j + 1] - prefixSum[i]);
                    }
                }
            }
        }

        // The final answer is the minimum cost to merge all stones (0 to n-1) into 1 pile.
        if (dp[0][n - 1][1] == INF) {
            return -1; // If it's impossible to merge all stones, return -1.
        }
        return dp[0][n - 1][1];
    }
};