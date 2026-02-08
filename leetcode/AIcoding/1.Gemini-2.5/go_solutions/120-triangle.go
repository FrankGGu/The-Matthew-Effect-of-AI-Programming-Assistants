package main

import "math"

func minimumTotal(triangle [][]int) int {
	n := len(triangle)
	if n == 0 {
		return 0
	}

	dp := make([]int, n)

	for j := 0; j < n; j++ {
		dp[j] = triangle[n-1][j]
	}

	for i := n - 2; i >= 0; i-- {
		for j := 0; j <= i; j++ {
			dp[j] = triangle[i][j] + int(math.Min(float64(dp[j]), float64(dp[j+1])))
		}
	}

	return dp[0]
}