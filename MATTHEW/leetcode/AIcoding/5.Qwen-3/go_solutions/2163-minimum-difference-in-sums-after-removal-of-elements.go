package main

func minimumSum(nums []int) int {
	n := len(nums)
	minDiff := 1e9

	for i := 1; i < n-1; i++ {
		leftSum := 0
		for j := 0; j < i; j++ {
			leftSum += nums[j]
		}
		rightSum := 0
		for j := i + 1; j < n; j++ {
			rightSum += nums[j]
		}
		diff := abs(leftSum - rightSum)
		if diff < minDiff {
			minDiff = diff
		}
	}

	return minDiff
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}