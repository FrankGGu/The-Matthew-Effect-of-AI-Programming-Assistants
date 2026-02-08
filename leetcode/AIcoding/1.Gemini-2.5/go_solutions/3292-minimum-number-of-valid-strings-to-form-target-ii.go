package main

import "math"

func minimumNumberOfValidStringsToFormTargetII(target string, words []string) int {
	n := len(target)
	dp := make([]int, n+1)

	for i := 0; i <= n; i++ {
		dp[i] = math.MaxInt32
	}
	dp[0] = 0

	for i := 1; i <= n; i++ {
		for _, word := range words {
			if i >= len(word) {
				if target[i-len(word):i] == word {
					if dp[i-len(word)] != math.MaxInt32 {
						dp[i] = min(dp[i], dp[i-len(word)]+1)
					}
				}
			}
		}
	}

	if dp[n] == math.MaxInt32 {
		return -1
	}
	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}