func countRoutes(locations []int, start int, finish int, fuel int) int {
	n := len(locations)
	mod := 1_000_000_007

	// dp[f][c] represents the number of ways to reach city