package main

func numberOfWays(n int, k int) int {
	const MOD = 1e9 + 7

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
	}

	dp[0][0] = 1

	for i := 1; i <= n; i++ {
		for j := 1; j <= k; j++ {
			// Case 1: The tallest stick (stick 'i') is placed at the leftmost position.
			// It is always visible. The remaining i-1 sticks must form j-1 visible sticks.
			ways1 := dp[i-1][j-1]

			// Case 2: The tallest stick (stick 'i') is NOT placed at the leftmost position.
			// It is placed among the i-1 smaller sticks. Since it's the tallest, it will
			// always be hidden by the stick immediately to its left.
			// There are (i-1) possible positions for stick 'i' among the i-1 smaller sticks,
			// such that it's not the first stick.
			// The remaining i-1 sticks must form j visible sticks.
			ways2 := (i - 1) * dp[i-1][j]

			dp[i][j] = (ways1 + ways2) % MOD
		}
	}

	return dp[n][k]
}