func numRollsToTarget(n int, k int, target int) int {
	const MOD = 1e9 + 7

	// dp[j] represents the number of ways to achieve sum 'j' using the current number of dice.
	// We use a 1D DP array to optimize space, where dp[j