package main

import (
	"sort"
)

func numSubseq(nums []int, target int) int {
	sort.Ints(nums)
	n := len(nums)
	mod := 1_000_000_007

	powers := make([]int, n)
	powers[0] = 1
	for i := 1; i < n; i++ {
		powers[i] = (powers[i-1] * 2) % mod
	}

	count := 0
	left := 0
	right := n - 1

	for left <= right {
		if nums[left]+nums[right] <= target {
			count = (count + powers[right-left]) % mod
			left++
		} else {
			right--
		}
	}

	return count
}