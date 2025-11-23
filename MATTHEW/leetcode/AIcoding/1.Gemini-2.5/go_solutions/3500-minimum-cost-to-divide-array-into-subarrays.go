package main

import (
	"math"
)

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func minimumCost(nums []int, price int) int {
	n := len(nums)

	trimValues := make([][]int, n)
	for j := 0; j < n; j++ {
		trimValues[j] = make([]int, n+1)
		currentTrim := 0
		freq := make(map[int]int)
		for i := j; i < n; i++ {
			x := nums[i]
			freq[x]++
			if freq[x] >= 2 {
				currentTrim++
			}
			trimValues[j][i+1] = currentTrim
		}
	}

	dp := make([]int64, n+1)
	dp[0] = 0

	for i := 1; i <= n; i++ {
		dp[i] = math.MaxInt64
		for j := 0; j < i; j++ {
			costLastSubarray := int664(trimValues[j][i]) + int64(price)
			dp[i] = min(dp[i], dp[j]+costLastSubarray)
		}
	}

	return int(dp[n])
}