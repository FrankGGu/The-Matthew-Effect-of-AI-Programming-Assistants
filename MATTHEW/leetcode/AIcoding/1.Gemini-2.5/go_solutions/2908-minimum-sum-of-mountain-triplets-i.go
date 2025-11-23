package main

import "math"

func minimumSum(nums []int) int {
	n := len(nums)
	minSum := math.MaxInt32

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				if nums[i] < nums[j] && nums[k] < nums[j] {
					currentSum := nums[i] + nums[j] + nums[k]
					if currentSum < minSum {
						minSum = currentSum
					}
				}
			}
		}
	}

	if minSum == math.MaxInt32 {
		return -1
	}
	return minSum
}