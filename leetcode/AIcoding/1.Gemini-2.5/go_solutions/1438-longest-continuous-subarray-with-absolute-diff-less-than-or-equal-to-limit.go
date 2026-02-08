package main

import (
	"math"
)

func longestSubarray(nums []int, limit int) int {
	minDeque := []int{} // Stores indices in increasing order of nums[index]
	maxDeque := []int{} // Stores indices in decreasing order of nums[index]

	left := 0
	maxLength := 0

	for right := 0; right < len(nums); right++ {
		// Maintain maxDeque (decreasing order)
		for len(maxDeque) > 0 && nums[maxDeque[len(maxDeque)-1]] <= nums[right] {
			maxDeque = maxDeque[:len(maxDeque)-1]
		}
		maxDeque = append(maxDeque, right)

		// Maintain minDeque (increasing order)
		for len(minDeque) > 0 && nums[minDeque[len(minDeque)-1]] >= nums[right] {
			minDeque = minDeque[:len(minDeque)-1]
		}
		minDeque = append(minDeque, right)

		// Check the window validity
		for nums[maxDeque[0]]-nums[minDeque[0]] > limit {
			left++
			// Remove elements from deques if their index is outside the current window [left, right]
			if maxDeque[0] < left {
				maxDeque = maxDeque[1:]
			}
			if minDeque[0] < left {
				minDeque = minDeque[1:]
			}
		}

		maxLength = int(math.Max(float64(maxLength), float64(right-left+1)))
	}

	return maxLength
}