class Solution {
    public long stoneGameVIII(int[] stones) {
        int n = stones.length;

        // Calculate prefix sums. P[k] stores sum(stones[0]...stones[k-1]).
        // P[0] = 0
        long[] P = new long[n + 1];
        for (int i = 0; i < n; i++) {
            P[i + 1] = P[i] + stones[i];
        }

        // dp[i] represents the maximum score difference Alice can achieve
        // if the game starts with stones[i...n-1].
        // Alice chooses an index k (i < k < n) to remove stones[i...k-1].
        // Her score increases by sum(stones[i...k-1]) = P[k] - P[i].
        // The game continues with stones[k...n-1], where the next player (Bob)
        // will try to minimize the difference, which from Alice's perspective
        // is -dp[k].
        // So, dp[i] = max_{i+1 <= k < n} ( (P[k] - P[i]) - dp[k] )
        // dp[i] = -P[i] + max_{i+1 <= k < n} (P[k] - dp[k])

        // Let M[j] = max_{j <= k < n} (P[k] - dp[k]).
        // Then dp[i] = -P[i] + M[i+1].
        // And M[i] = max(P[i] - dp[i], M[i+1]).

        // Base case: If only one stone (stones[n-1]) remains, no moves are possible.
        // So, dp[n-1] = 0.
        // Initialize M[n-1]:
        // M[n-1] = P[n-1] - dp[n-1] = P[n-1] - 0 = P[n-1].
        long max_val_so_far = P[n - 1]; // This variable will store M[i+1] then M[i]

        // current_dp will store dp[i] in each iteration.
        // We iterate from i = n-2 down to 0.
        long current_dp = 0; // This will eventually hold dp[0]

        for (int i = n - 2; i >= 0; i--) {
            // Calculate dp[i] using the previously computed max_val_so_far (which is M[i+1])
            current_dp = -P[i] + max_val_so_far;

            // Update max_val_so_far to M[i] for the next iteration.
            // M[i] = max(P[i] - dp[i], M[i+1])
            max_val_so_far = Math.max(P[i] - current_dp, max_val_so_far);
        }

        // The final answer is dp[0], which is stored in current_dp after the loop finishes.
        return current_dp;
    }
}