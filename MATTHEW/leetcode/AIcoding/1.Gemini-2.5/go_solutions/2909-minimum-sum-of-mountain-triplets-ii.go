package main

import (
	"math"
)

func minimumSum(nums []int) int {
	n := len(nums)
	if n < 3 {
		return -1
	}

	leftMin := make([]int, n)
	rightMin := make([]int, n)

	leftMin[0] = math.MaxInt32
	for i := 1; i < n; i++ {
		leftMin[i] = min(leftMin[i-1], nums[i-1])
	}

	rightMin[n-1] = math.MaxInt32
	for i := n - 2; i >= 0; i-- {
		rightMin[i] = min(rightMin[i+1], nums[i+1])
	}

	minSum := math.MaxInt32

	for j := 1; j < n-1; j++ {
		if leftMin[j] < nums[j] && rightMin[j] < nums[j] {
			currentSum := leftMin[j] + nums[j] + rightMin[j]
			minSum = min(minSum, currentSum)
		}
	}

	if minSum == math.MaxInt32 {
		return -1
	}
	return minSum
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}