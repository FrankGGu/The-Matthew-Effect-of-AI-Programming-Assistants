import "math"

func champagneTower(poured int, query_row int, query_glass int) float64 {
	// dp[i][j] represents the total amount of champagne that would flow through glass (i, j)
	// if it had infinite capacity.
	// We need to calculate this up to query_row