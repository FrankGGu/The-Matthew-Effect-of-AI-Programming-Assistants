package main

import (
	"sort"
)

func jobScheduling(startTime []int, endTime []int, profit []int) int {
	jobs := make([][]int, len(startTime))
	for i := range startTime {
		jobs[i] = []int{startTime[i], endTime[i], profit[i]}
	}
	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i][1] < jobs[j][1]
	})
	n := len(jobs)
	dp := make([]int, n+1)
	for i := 0; i < n; i++ {
		start, end, profit := jobs[i][0], jobs[i][1], jobs[i][2]
		low, high := 0, i
		for low < high {
			mid := (low + high) / 2
			if jobs[mid][1] <= start {
				low = mid + 1
			} else {
				high = mid
			}
		}
		dp[i+1] = max(dp[i], dp[low]+profit)
	}
	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}