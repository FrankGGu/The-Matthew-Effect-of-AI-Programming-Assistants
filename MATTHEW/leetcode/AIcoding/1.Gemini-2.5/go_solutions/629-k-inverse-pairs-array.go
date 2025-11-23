func kInversePairs(n int, k int) int {
	const MOD int = 1e9 + 7

	// dp[j] will store the number of permutations of 'i' elements with 'j' inverse pairs.
	// We use two rows for space optimization: 'dp' for current 'i' and 'prevDp' for '