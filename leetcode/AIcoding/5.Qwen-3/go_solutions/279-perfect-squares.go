package main

import "math"

func numSquares(n int) int {
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		min := math.MaxInt32
		j := 1
		for j*j <= i {
			if dp[i-j*j] < min {
				min = dp[i-j*j]
			}
			j++
		}
		dp[i] = min + 1
	}
	return dp[n]
}