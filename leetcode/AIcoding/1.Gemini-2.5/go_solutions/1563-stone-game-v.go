package main

import "math"

func stoneGameV(stoneValue []int) int {
	n := len(stoneValue)
	if n == 0 {
		return 0
	}

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + stoneValue[i]
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1

			for k := i; k < j; k++ {
				sumL := prefixSum[k+1] - prefixSum[i]
				sumR := prefixSum[j+1] - prefixSum[k+1]

				currentScore := 0
				if sumL < sumR {
					currentScore = sumL + dp[i][k]
				} else if sumL > sumR {
					currentScore = sumR + dp[k+1][j]
				} else { // sumL == sumR
					currentScore = sumL + int(math.Max(float64(dp[i][k]), float64(dp[k+1][j])))
				}
				dp[i][j] = int(math.Max(float64(dp[i][j]), float64(currentScore)))
			}
		}
	}

	return dp[0][n-1]
}