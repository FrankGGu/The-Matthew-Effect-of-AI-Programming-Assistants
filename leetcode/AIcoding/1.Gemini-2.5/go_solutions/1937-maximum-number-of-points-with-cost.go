package main

import "math"

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}

func maxPoints(points [][]int) int64 {
	m := len(points)
	n := len(points[0])

	dp := make([]int64, n)
	for j := 0; j < n; j++ {
		dp[j] = int64(points[0][j])
	}

	for i := 1; i < m; i++ {
		newDp := make([]int64, n)

		leftMaxVal := math.MinInt64
		for j := 0; j < n; j++ {
			leftMaxVal = max(leftMaxVal, dp[j]+int64(j))
			newDp[j] = leftMaxVal - int64(j)
		}

		rightMaxVal := math.MinInt64
		for j := n - 1; j >= 0; j-- {
			rightMaxVal = max(rightMaxVal, dp[j]-int64(j))
			newDp[j] = max(newDp[j], rightMaxVal+int64(j))
			newDp[j] += int64(points[i][j])
		}
		dp = newDp
	}

	var maxVal int64 = dp[0]
	for j := 1; j < n; j++ {
		maxVal = max(maxVal, dp[j])
	}

	return maxVal
}