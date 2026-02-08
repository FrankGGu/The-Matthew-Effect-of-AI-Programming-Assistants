func countVowelPermutation(n int) int {
	const MOD = 1000000007

	// dp[k] stores the counts of valid strings of length k+1 ending with each vowel.
	// We use separate variables to optimize space (only need previous state).
	// a_count: