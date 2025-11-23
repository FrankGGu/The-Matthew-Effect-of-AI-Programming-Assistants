func numPermsDISequence(s string) int {
	n := len(s)
	mod := 1_000_000_007

	// dp[i][j] represents the number of valid permutations of length (i+1)
	// (using i+1 distinct numbers) that satisfy the