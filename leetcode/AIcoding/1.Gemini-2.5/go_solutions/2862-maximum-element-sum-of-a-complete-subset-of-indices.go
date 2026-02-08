package main

import "math"

func maximumSum(nums []int) int {
	n := len(nums)
	maxSum := 0

	for s := 1; s <= n; s++ {
		currentSum := 0
		for k := 1; ; k++ {
			idx := s * k * k
			if idx > n {
				break
			}
			currentSum += nums[idx-1]
		}
		if currentSum > maxSum {
			maxSum = currentSum
		}
	}

	return maxSum
}