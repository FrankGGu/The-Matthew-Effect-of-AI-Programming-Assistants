package main

import (
	"sort"
)

func minimizeMax(nums []int, p int) int {
	sort.Ints(nums)
	n := len(nums)
	left, right := 0, nums[n-1]-nums[0]

	for left < right {
		mid := left + (right-left)/2
		if canFormPairs(nums, mid, p) {
			right = mid
		} else {
			left = mid + 1
		}
	}
	return left
}

func canFormPairs(nums []int, maxDiff int, p int) bool {
	count := 0
	i := 0
	for i < len(nums)-1 {
		if nums[i+1]-nums[i] <= maxDiff {
			count++
			i += 2
		} else {
			i++
		}
	}
	return count >= p
}