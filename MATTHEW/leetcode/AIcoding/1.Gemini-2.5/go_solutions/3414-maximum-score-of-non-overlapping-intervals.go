package main

import (
	"sort"
)

type Interval struct {
	Start int
	End   int
	Score int
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumScore(intervals [][]int, scores []int) int {
	n := len(intervals)
	if n == 0 {
		return 0
	}

	combinedIntervals := make([]Interval, n)
	for i := 0; i < n; i++ {
		combinedIntervals[i] = Interval{
			Start: intervals[i][0],
			End:   intervals[i][1],
			Score: scores[i],
		}
	}

	sort.Slice(combinedIntervals, func(i, j int) bool {
		if combinedIntervals[i].End != combinedIntervals[j].End {
			return combinedIntervals[i].End < combinedIntervals[j].End
		}
		return combinedIntervals[i].Start < combinedIntervals[j].Start
	})

	dp := make([]int, n+1)

	for i := 0; i < n; i++ {
		currentInterval := combinedIntervals[i]

		dp[i+1] = dp[i]

		k := sort.Search(i, func(idx int) bool {
			return combinedIntervals[idx].End > currentInterval.Start
		})

		prevScore := 0
		if k > 0 {
			prevScore = dp[k]
		}

		scoreIfIncluded := currentInterval.Score + prevScore
		dp[i+1] = max(dp[i+1], scoreIfIncluded)
	}

	return dp[n]
}