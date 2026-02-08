import "math"

func cherryPickup(grid [][]int) int {
	n := len(grid)
	// dp[s][r1][r2] represents the maximum cherries collected
	// when both people have taken 's' steps,
	// person 1 is at (r1, s - r1), and person 2 is at