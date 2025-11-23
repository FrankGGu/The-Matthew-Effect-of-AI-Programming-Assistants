package main

import (
	"sort"
)

func sumSubseqWidths(nums []int) int {
	sort.Ints(nums)
	n := len(nums)
	mod := 1_000_000_007

	pow2 := make([]int, n)
	pow2[0] = 1
	for i := 1; i < n; i++ {
		pow2[i] = (pow2[i-1] * 2) % mod
	}

	totalWidth := 0
	for i := 0; i < n; i++ {
		// Contribution of nums[i] as maximum: nums[i] * 2^i
		// Contribution of nums[i] as minimum: nums[i] * 2^(n-1-i)
		// Total contribution for nums[i]: nums[i] * (2^i - 2^(n-1-i))

		term := (pow2[i] - pow2[n-1-i] + mod) % mod
		totalWidth = (totalWidth + (nums[i] * term) % mod) % mod
	}

	return totalWidth
}