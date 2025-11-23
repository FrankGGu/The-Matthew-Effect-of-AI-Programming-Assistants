package main

import (
	"sort"
)

func purchasePlans(nums []int, x int) int {
	sort.Ints(nums)
	count := 0
	left := 0
	right := len(nums) - 1
	mod := 1_000_000_007

	for left < right {
		if nums[left]+nums[right] <= x {
			// If nums[left] + nums[right] <= x, it means nums[left] can be paired
			// with nums[right] and all elements between left and right (nums[left+1] to nums[right-1]).
			// The number of such elements is (right - left).
			// These form (right - left) valid pairs with nums[left].
			count = (count + (right - left)) % mod
			left++ // Move left pointer to try a larger sum
		} else {
			// If nums[left] + nums[right] > x, then nums[right] is too large
			// to be paired with nums[left] (and any element to its right, which are even larger).
			// Move right pointer to try a smaller sum.
			right--
		}
	}
	return count
}