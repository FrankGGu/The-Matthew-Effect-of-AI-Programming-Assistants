package main

import (
	"sort"
)

type Job struct {
	start int
	end   int
	profit int
}

func jobScheduling(startTime []int, endTime []int, profit []int) int {
	n := len(startTime)
	jobs := make([]Job, n)
	for i := 0; i < n; i++ {
		jobs[i] = Job{start: startTime[i], end: endTime[i], profit: profit[i]}
	}
	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i].end < jobs[j].end
	})

	dp := make([]int, n)
	dp[0] = jobs[0].profit
	for i := 1; i < n; i++ {
		dp[i] = jobs[i].profit
		for j := 0; j < i; j++ {
			if jobs[j].end <= jobs[i].start {
				dp[i] = max(dp[i], dp[j]+jobs[i].profit)
			}
		}
	}

	maxProfit := 0
	for _, p := range dp {
		maxProfit = max(maxProfit, p)
	}
	return maxProfit
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}