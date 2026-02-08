package main

import (
	"sort"
)

func waysToSplit(nums []int) int {
	n := len(nums)
	prefixSums := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSums[i+1] = prefixSums[i] + int64(nums[i])
	}

	count := 0
	mod := 1_000_000_007

	// i is the last index of the left subarray.
	// j is the last index of the middle subarray.
	// left: nums[0...i]
	// mid: nums[i+1...j]
	// right: nums[j+1...n-1]
	//
	// Conditions:
	// 1. 0 <= i < j < n-1 (each subarray must be non-empty)
	//    This means i can go from 0 up to n-3.
	//    j can go from i+1 up to n-2.
	//
	// 2. sum(left) <= sum(mid)
	//    prefixSums[i+1] <= prefixSums[j+1] - prefixSums[i+1]
	//    2 * prefixSums[i+1] <= prefixSums[j+1]
	//
	// 3. sum(mid) <= sum(right)
	//    prefixSums[j+1] - prefixSums[i+1] <= prefixSums[n] - prefixSums[j+1]
	//    2 * prefixSums[j+1] <= prefixSums[n] + prefixSums[i+1]
	//    prefixSums[j+1] <= (prefixSums[n] + prefixSums[i+1]) / 2

	// Iterate i from 0 to n-3 (inclusive)
	for i := 0; i < n-2; i++ {
		leftSum := prefixSums[i+1]

		// Calculate the required range for prefixSums[j+1]
		minPjPlus1 := 2 * leftSum
		maxPjPlus1 := (prefixSums[n] + leftSum) / 2

		// Find the smallest index `k` (which is j+1) such that prefixSums[k] >= minPjPlus1
		// `sort.Search` returns the smallest index `k` in `[0, n]` for which the function returns true.
		k_start_raw := sort.Search(n+1, func(k int) bool {
			return prefixSums[k] >= minPjPlus1
		})

		// Find the largest index `k` (which is j+1) such that prefixSums[k] <= maxPjPlus1
		// This is equivalent to finding the first `k_next` such that prefixSums[k_next] > maxPjPlus1,
		// then `k` is `k_next - 1`.
		k_end_next_raw := sort.Search(n+1, func(k int) bool {
			return prefixSums[k] > maxPjPlus1
		})
		k_end_raw := k_end_next_raw - 1

		// Clamp the found indices to the valid range for j+1: [i+2, n-1]
		// j must be at least i+1, so j+1 (k) must be at least i+2.
		// j must be at most n-2, so j+1 (k) must be at most n-1.
		k_actual_start := max(k_start_raw, i+2)
		k_actual_end := min(k_end_raw, n-1)

		// If a valid range of k (j+1) exists, add the count.
		if k_actual_start <= k_actual_end {
			count = (count + (k_actual_end - k_actual_start + 1)) % mod
		}
	}

	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}