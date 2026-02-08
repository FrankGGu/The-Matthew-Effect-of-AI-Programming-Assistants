package main

import (
	"sort"
)

func maxEnvelopes(envelopes [][]int) int {
	sort.Slice(envelopes, func(i, j int) bool {
		if envelopes[i][0] == envelopes[j][0] {
			return envelopes[i][1] > envelopes[j][1]
		}
		return envelopes[i][0] < envelopes[j][0]
	})

	dp := []int{}
	for _, envelope := range envelopes {
		h := envelope[1]
		left, right := 0, len(dp)
		for left < right {
			mid := (left + right) / 2
			if dp[mid] < h {
				left = mid + 1
			} else {
				right = mid
			}
		}
		if left == len(dp) {
			dp = append(dp, h)
		} else {
			dp[left] = h
		}
	}
	return len(dp)
}