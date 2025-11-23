package main

import (
	"sort"
)

func minAbsDifference(nums []int, queries [][]int) []int {
	n := len(nums)
	results := make([]int, len(queries))
	sortedNums := make([]int, n)
	copy(sortedNums, nums)
	sort.Ints(sortedNums)

	for i, query := range queries {
		left, right := query[0], query[1]
		subArray := nums[left:right+1]
		sort.Ints(subArray)

		minDiff := int(1e9)
		for j := 0; j < len(subArray)-1; j++ {
			diff := subArray[j+1] - subArray[j]
			if diff < minDiff {
				minDiff = diff
			}
		}
		if minDiff == int(1e9) {
			minDiff = -1
		}
		results[i] = minDiff
	}
	return results
}