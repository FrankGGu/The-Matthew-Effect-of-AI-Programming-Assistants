package main

func numberOfSets(n int, k int) int {
	const MOD = 1_000_000_007

	// dp[i][j] represents the number of ways to choose j non-overlapping line segments
	// using points from 0 to i (inclusive).
	// i ranges from 0 to n-1.
	// j ranges from 0 to k.
	dp := make([][]int, n)
	for r := range dp {
		dp[r] = make([]int, k+1)
	}

	// Base case: dp[i][0] = 1 for all i.
	// There is one way to choose 0 segments (the empty set), regardless of the number of points available.
	for i := 0; i < n; i++ {
		dp[i][0] = 1
	}

	// Iterate over the number of segments 'j' from 1 to k.
	for j := 1; j <= k; j++ {
		// S_prev_col_sum stores the sum of dp[p][j-1] for p from 0 to current_i-1.
		// This sum is needed for the recurrence relation.
		// It represents the sum of ways to form j-1 segments using points up to 'p'.
		S_prev_col_sum := 0

		// Iterate over the points 'i' from 0 to n-1.
		// 'i' is the maximum point index considered.
		for i := 0; i < n; i++ {
			// Case 1: Point 'i' is not used as an endpoint for any segment.
			// In this case, we need to choose 'j' segments from points 0 to i-1.
			// This contributes dp[i-1][j] ways. If i=0, this term is 0.
			val1 := 0
			if i > 0 {
				val1 = dp[i-1][j]
			}

			// Case 2: Point 'i' is used as the right endpoint of the j-th segment.
			// Let this j-th segment be [p, i], where 0 <= p < i.
			// The previous j-1 segments must be chosen from points 0 to p.
			// The number of ways to do this is dp[p][j-1].
			// We need to sum dp[p][j-1] for all possible 'p' from 0 to i-1.
			// This sum is accumulated in S_prev_col_sum.
			val2 := S_prev_col_sum

			// The total number of ways for dp[i][j] is the sum of ways from Case 1 and Case 2.
			dp[i][j] = (val1 + val2) % MOD

			// Update S_prev_col_sum for the next iteration (i+1).
			// For the next 'i', S_prev_col_sum will need to include dp[i][j-1].
			// dp[i][j-1] is the value from the current row 'i' but the previous column 'j-1'.
			S_prev_col_sum = (S_prev_col_sum + dp[i][j-1]) % MOD
		}
	}

	// The final answer is the number of ways to choose 'k' segments using points 0 to n-1.
	return dp[n-1][k]
}