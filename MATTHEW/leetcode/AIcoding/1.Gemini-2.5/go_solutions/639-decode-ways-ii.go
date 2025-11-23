func numDecodings(s string) int {
	n := len(s)
	if n == 0 {
		return 1
	}

	const MOD int = 1_000_000_007

	// dp[i] represents the number of ways to decode s[0...i-1