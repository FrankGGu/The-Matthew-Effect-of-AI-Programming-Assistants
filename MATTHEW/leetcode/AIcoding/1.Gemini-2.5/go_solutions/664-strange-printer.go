package main

import "math"

func strangePrinter(s string) int {
	n := len(s)
	if n == 0 {
		return 0
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for i := 0; i < n; i++ {
		dp[i][i] = 1
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1

			dp[i][j] = 1 + dp[i+1][j] // Option 1: Print s[i] alone, then solve for s[i+1...j]

			for k := i + 1; k <= j; k++ {
				if s[k] == s[i] {
					costRight := 0
					if k+1 <= j {
						costRight = dp[k+1][j]
					}
					dp[i][j] = min(dp[i][j], dp[i][k-1]+costRight)
				}
			}
		}
	}

	return dp[0][n-1]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}