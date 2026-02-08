func countSpecialSubsequences(s string) int {
	const MOD = 1_000_000_007

	// dp[0]: count of subsequences ending with 'a'
	// dp[1]: count of subsequences ending with 'b' (formed by 'a's then 'b's)
	// dp[2]: count of subsequences ending with 'c' (formed by 'a's then 'b's then 'c's)
	dp := [3]int{0, 0, 0}

	for _, char := range s {
		if char == 'a' {
			// A new 'a' subsequence can be formed by just this 'a' (1).
			// Each existing 'a' subsequence can be extended by this 'a' (dp[0] new subsequences).
			// So, total 'a' subsequences = existing + existing + 1
			dp[0] = (2*dp[0] + 1) % MOD
		} else if char == 'b' {
			// A new 'ab' subsequence can be formed by extending each existing 'a' subsequence with this 'b' (dp[0] new subsequences).
			// Each existing 'ab' subsequence can be extended by this 'b' (dp[1] new subsequences).
			// So, total 'ab' subsequences = existing + existing + from_a
			dp[1] = (2*dp[1] + dp[0]) % MOD
		} else if char == 'c' {
			// A new 'abc' subsequence can be formed by extending each existing 'ab' subsequence with this 'c' (dp[1] new subsequences).
			// Each existing 'abc' subsequence can be extended by this 'c' (dp[2] new subsequences).
			// So, total 'abc' subsequences = existing + existing + from_ab
			dp[2] = (2*dp[2] + dp[1]) % MOD
		}
	}

	return dp[2]
}