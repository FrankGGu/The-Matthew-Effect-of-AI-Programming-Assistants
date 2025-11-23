func numTilings(n int) int {
	if n == 1 {
		return 1
	}
	if n == 2 {
		return 2
	}

	const MOD = 1_000_000_007

	// dp[i] represents the number of ways to tile a