package main

import (
	"fmt"
)

func maximizeTheCuts(n int, x int, y int, z int) int {
	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		if i-x >= 0 {
			dp[i] = max(dp[i], dp[i-x]+1)
		}
		if i-y >= 0 {
			dp[i] = max(dp[i], dp[i-y]+1)
		}
		if i-z >= 0 {
			dp[i] = max(dp[i], dp[i-z]+1)
		}
	}
	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	n, x, y, z := 7, 5, 2, 3
	fmt.Println(maximizeTheCuts(n, x, y, z))
}