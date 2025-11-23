package main

import (
	"sort"
)

func countFairPairs(nums []int, lower int, upper int) int64 {
	sort.Ints(nums)
	return countPairsSumLE(nums, upper) - countPairsSumLE(nums, lower-1)
}

func countPairsSumLE(arr []int, target int) int64 {
	n := len(arr)
	var count int64 = 0
	left, right := 0, n-1

	for left < right {
		if arr[left]+arr[right] <= target {
			// If arr[left] + arr[right] <= target, then all pairs (arr[left], arr[k])
			// where left < k <= right will also satisfy arr[left] + arr[k] <= target
			// because arr[k] <= arr[right] (array is sorted).
			// There are (right - left) such values for k.
			count += int64(right - left)
			left++ // Move left pointer to try a larger sum
		} else {
			// If arr[left] + arr[right] > target, then arr[right] is too large for arr[left].
			// We need to decrease the sum, so move right pointer inwards.
			right--
		}
	}
	return count
}