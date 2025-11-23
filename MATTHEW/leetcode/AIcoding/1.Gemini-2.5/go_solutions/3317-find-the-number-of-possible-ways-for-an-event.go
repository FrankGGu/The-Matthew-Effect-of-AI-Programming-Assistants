package main

import (
	"sort"
)

func findTheNumberOfPossibleWaysForAnEvent(events [][]int, k int) int {
	n := len(events)

	sort.Slice(events, func(i, j int) bool {
		if events[i][0] != events[j][0] {
			return events[i][0] < events[j][0]
		}
		return events[i][1] < events[j][1]
	})

	memo := make([][]int, n+1)
	for i := range memo {
		memo[i] = make([]int, k+1)
		for j := range memo[i] {
			memo[i][j] = -1
		}
	}

	findNextEvent := func(currentEventEnd int, startIndex int) int {
		low, high := startIndex, n-1
		ans := n
		for low <= high {
			mid := low + (high-low)/2
			if events[mid][0] > currentEventEnd {
				ans = mid
				high = mid - 1
			} else {
				low = mid + 1
			}
		}
		return ans
	}

	var dp func(idx, count int) int
	dp = func(idx, count int) int {
		if count == 0 {
			return 1
		}
		if idx == n {
			return 0
		}
		if memo[idx][count] != -1 {
			return memo[idx][count]
		}

		ways := dp(idx+1, count)

		nextIdx := findNextEvent(events[idx][1], idx+1)
		ways += dp(nextIdx, count-1)

		memo[idx][count] = ways
		return ways
	}

	return dp(0, k)
}