package main

import (
	"sort"
)

func maximumBeauty(nums []int, k int) int {
	sort.Ints(nums)
	n := len(nums)
	ans := 0
	left := 0
	for right := 0; right < n; right++ {
		for nums[right]-nums[left] > 2*k {
			left++
		}
		ans = max(ans, right-left+1)
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}