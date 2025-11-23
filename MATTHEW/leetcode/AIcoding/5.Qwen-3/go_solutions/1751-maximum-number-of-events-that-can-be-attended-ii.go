package main

import (
	"sort"
)

func maxEvents(events [][]int) int {
	sort.Slice(events, func(i, j int) bool {
		return events[i][1] < events[j][1]
	})

	n := len(events)
	dp := make([]int, n+1)
	for i := 0; i < n; i++ {
		start, end := events[i][0], events[i][1]
		j := i
		for j >= 0 && events[j][1] >= start {
			j--
		}
		dp[i+1] = max(dp[i], dp[j+1]+1)
	}
	return dp[n]
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}