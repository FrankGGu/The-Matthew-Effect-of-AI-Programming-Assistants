package main

import "sort"

func maxScoreIntervals(intervals [][]int) int {
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][1] < intervals[j][1]
	})

	n := len(intervals)
	dp := make([]int, n)
	dp[0] = intervals[0][2]

	for i := 1; i < n; i++ {
		dp[i] = intervals[i][2]
		for j := i - 1; j >= 0; j-- {
			if intervals[j][1] < intervals[i][0] {
				dp[i] = max(dp[i], dp[j]+intervals[i][2])
				break
			}
		}
	}

	res := 0
	for _, score := range dp {
		res = max(res, score)
	}

	return res
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}