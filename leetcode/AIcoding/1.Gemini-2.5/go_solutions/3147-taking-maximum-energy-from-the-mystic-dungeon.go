package main

import "math"

func maximumEnergy(energy []int, k int) int {
	n := len(energy)
	dp := make([]int, n)

	for i := n - 1; i >= 0; i-- {
		currentEnergy := energy[i]
		if i+k < n {
			currentEnergy += dp[i+k]
		}
		dp[i] = currentEnergy
	}

	maxEnergy := math.MinInt32
	for i := 0; i < n; i++ {
		if dp[i] > maxEnergy {
			maxEnergy = dp[i]
		}
	}

	return maxEnergy
}