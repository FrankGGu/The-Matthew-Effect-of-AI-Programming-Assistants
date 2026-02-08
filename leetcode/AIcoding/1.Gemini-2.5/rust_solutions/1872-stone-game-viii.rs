impl Solution {
    pub fn stone_game_viii(stones: Vec<i32>) -> i64 {
        let n = stones.len();

        // Calculate prefix sums. p_sums[k] = sum(stones[0...k-1]).
        // p_sums will have n+1 elements, where p_sums[0] = 0.
        let mut p_sums: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            p_sums[i + 1] = p_sums[i] + stones[i] as i64;
        }

        // dp[i] represents the maximum score the current player can achieve
        // if it's their turn and they must choose an index j such that i <= j < n-1.
        // The current player takes sum(stones[i...j]), and then the opponent plays optimally
        // from index j+1.
        // The recurrence relation is:
        // dp[i] = max_{i <= j < n-1} ( (p_sums[j+1] - p_sums[i]) - dp[j+1] )
        // This can be rewritten as:
        // dp[i] = -p_sums[i] + max_{i <= j < n-1} (p_sums[j+1] - dp[j+1])
        // Let k = j+1. Then the max term becomes max_{i+1 <= k <= n-1} (p_sums[k] - dp[k]).

        // Base case: dp[n-1] = 0, as no moves are possible if starting from index n-1.
        // We compute dp[i] from n-2 down to 0.

        // Initialize dp array. dp[n-1] is 0.
        let mut dp: Vec<i64> = vec![0; n];

        // `max_val_expr` stores `max_{k \in [i+1, n-1]} (p_sums[k] - dp[k])`.
        // For the first iteration (i = n-2), this needs to be `p_sums[n-1] - dp[n-1]`.
        let mut max_val_expr = p_sums[n - 1] - dp[n - 1]; // dp[n-1] is 0

        // Iterate from n-2 down to 0
        for i in (0..n - 1).rev() {
            // Calculate dp[i] using the current `max_val_expr`
            dp[i] = max_val_expr - p_sums[i];

            // Update `max_val_expr` for the next iteration (i-1).
            // The new `max_val_expr` should include the term `p_sums[i] - dp[i]`.
            // So, `max_val_expr` for `i-1` will be `max(current_max_val_expr, p_sums[i] - dp[i])`.
            max_val_expr = max_val_expr.max(p_sums[i] - dp[i]);
        }

        // The problem asks for the maximum score Alice can get.
        // Alice starts the game by choosing an index `i` (0 <= i < n-1)
        // and takes `stones[0...i]`. This is `p_sums[i+1] - p_sums[0]`.
        // Then Bob plays optimally from `i+1`.
        // So Alice's total score is `(p_sums[i+1] - p_sums[0]) - dp[i+1]`.
        // Alice wants to maximize this over all possible `i`.
        // This is `max_{0 <= i < n-1} (p_sums[i+1] - dp[i+1]) - p_sums[0]`.
        // Since `p_sums[0]` is 0, this is `max_{0 <= i < n-1} (p_sums[i+1] - dp[i+1])`.
        // This is exactly what `max_val_expr` holds after the loop finishes,
        // specifically `max_{k \in [0+1, n-1]} (p_sums[k] - dp[k])` which is `max_{k \in [1, n-1]} (p_sums[k] - dp[k])`.
        // However, the `dp[0]` calculated by the loop is `max_val_expr - p_sums[0]`,
        // which is `max_{k \in [1, n-1]} (p_sums[k] - dp[k]) - 0`.
        // So, `dp[0]` directly gives the answer.
        dp[0]
    }
}