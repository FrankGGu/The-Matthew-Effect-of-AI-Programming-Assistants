package main

import (
	"math"
)

func minimumChanges(s string, k int) int {
	n := len(s)

	cost := make([][]int, n)
	for i := range cost {
		cost[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			currentCost := 0
			subLen := j - i + 1
			for p := 0; p < subLen/2; p++ {
				charAtP := s[i+p]
				matchFound := false

				if charAtP == s[j-p] {
					matchFound = true
				}

				if !matchFound && (j-p-1 >= i) && (charAtP == s[j-p-1]) {
					matchFound = true
				}

				if !matchFound && (j-p-2 >= i) && (charAtP == s[j-p-2]) {
					matchFound = true
				}

				if !matchFound {
					currentCost++
				}
			}
			cost[i][j] = currentCost
		}
	}

	dp := make([][]int, n+1)
	for i := range dp {
		dp[i] = make([]int, k+1)
		for j := range dp[i] {
			dp[i][j] = math.MaxInt32
		}
	}

	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		for kVal := 1; kVal <= k; kVal++ {
			for j := 0; j < i; j++ {
				if dp[j][kVal-1] != math.MaxInt32 {
					dp[i][kVal] = min(dp[i][kVal], dp[j][kVal-1]+cost[j][i-1])
				}
			}
		}
	}

	return dp[n][k]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}