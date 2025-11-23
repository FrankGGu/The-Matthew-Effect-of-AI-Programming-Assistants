func countHousePlacements(n int) int {
	mod := 1_000_000_007

	// For a single side of the street with 'k' plots, let dp[k] be the number of ways
	// to place houses such that no two houses are adjacent.