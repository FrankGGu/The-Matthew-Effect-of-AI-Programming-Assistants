const MOD int = 1e9 + 7

func numberOfArrays(n int, m int, k int) int {
	// dp[j][k_count] represents the number of arrays of current length
	// ending with value 'j' and having 'k_count' matching adjacent pairs.
	// We use two DP