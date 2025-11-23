package main

import (
	"sort"
)

func canAliceWin(nums1 []int, nums2 []int, k int) bool {
	n := len(nums1)
	diffs := make([]int, n)
	for i := 0; i < n; i++ {
		diffs[i] = nums1[i] - nums2[i]
	}

	sort.Slice(diffs, func(i, j int) bool {
		return diffs[i] > diffs[j]
	})

	var aliceScoreDiff int64 = 0
	var bobScoreDiff int64 = 0

	for i := 0; i < k; i++ {
		if i%2 == 0 { // Alice's turn
			aliceScoreDiff += int64(diffs[i])
		} else { // Bob's turn
			bobScoreDiff += int64(diffs[i])
		}
	}

	return aliceScoreDiff > bobScoreDiff
}