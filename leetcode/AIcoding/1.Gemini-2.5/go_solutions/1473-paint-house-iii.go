import "math"

func minCost(houses []int, cost [][]int, m int, n int, target int) int {
    // dp[i][j][k] represents the minimum cost to paint the first i houses
    // such that the i-th house is painted with color j, and there are k neighborhoods.
    //