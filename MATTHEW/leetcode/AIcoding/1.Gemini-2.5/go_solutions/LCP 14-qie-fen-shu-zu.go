package main

import (
	"math"
)

func splitArray(nums []int, k int) int {
	left := 0
	right := 0
	for _, num := range nums {
		left = int(math.Max(float64(left), float64(num)))
		right += num
	}

	ans := right

	for left <= right {
		mid := left + (right-left)/2
		if canSplit(nums, k, mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}

	return ans
}

func canSplit(nums []int, k int, maxSum int) bool {
	count := 1
	currentSum := 0
	for _, num := range nums {
		if currentSum+num <= maxSum {
			currentSum += num
		} else {
			count++
			currentSum = num
		}
	}
	return count <= k
}