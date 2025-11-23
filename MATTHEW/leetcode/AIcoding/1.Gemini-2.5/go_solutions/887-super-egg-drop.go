func superEggDrop(K int, N int) int {
	// dp[k] represents the maximum number of floors that can be determined
	// with k eggs using the current number of moves 'm'.
	// We use a single DP array to optimize space, where dp[k] stores the
	// result for 'k' eggs and 'm-1' moves when calculating for 'm' moves.
	dp := make([]int, K+1)

	m := 0 // m is the number of moves
	for dp[K] < N {
		m++ // Increment the number of moves

		// To correctly update dp[k] for the current 'm' using values from 'm-1',
		// we must iterate 'k' from K down to 1.
		// This ensures that when we calculate dp[k], dp[k-1] refers to the
		// value from the current 'm' iteration (egg breaks scenario) and
		// dp[k] refers to the value from the previous 'm-1' iteration (egg survives scenario).
		//
		// dp[m][k] = dp[m-1][k-1] + dp[m-1][k] + 1
		// In space-optimized form:
		// new_dp[k] = dp[k-1] (from current m) + dp[k] (from previous m) + 1
		// But here dp[k-1] is actually dp[m-1][k-1] because it's overwritten after dp[k].
		//
		// Correct interpretation for `dp[k] = dp[k-1] + dp[k] + 1`:
		// When calculating `dp[k]` for the current `m`:
		// `dp[k-1]` on the RHS is the value for `k-1` eggs and `m-1` moves (because it's not yet updated for current `m`).
		// `dp[k]` on the RHS is the value for `k` eggs and `m-1` moves (because it's not yet updated for current `m`).
		// This is why iterating `k` from `K` down to `1` is crucial.
		// If we iterated `k` from `1` to `K`, `dp[k-1]` would already be the value for `k-1` eggs and `m` moves.
		for k := K; k >= 1; k-- {
			dp[k] = dp[k-1] + dp[k] + 1
		}
	}
	return m
}