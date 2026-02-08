package main

import "math"

func largestSumOfAverages(nums []int, K int) float64 {
	n := len(nums)

	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	dp := make([][]float64, K+1)
	for k := 0; k <= K; k++ {
		dp[k] = make([]float64, n+1)
	}

	for i := 1; i <= n; i++ {
		dp[1][i] = float64(prefixSum[i]) / float64(i)
	}

	for k := 2; k <= K; k++ {
		for i := k; i <= n; i++ {
			for j := k - 1; j < i; j++ {
				currentGroupSum := prefixSum[i] - prefixSum[j]
				currentGroupCount := i - j
				currentGroupAvg := float64(currentGroupSum) / float64(currentGroupCount)

				dp[k][i] = math.Max(dp[k][i], dp[k-1][j]+currentGroupAvg)
			}
		}
	}

	return dp[K][n]
}