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

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func maxAbsoluteSum(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	maxSum := nums[0]
	currentMax := nums[0]
	minSum := nums[0]
	currentMin := nums[0]

	for i := 1; i < len(nums); i++ {
		// Kadane's algorithm to find maximum subarray sum
		currentMax = max(nums[i], currentMax+nums[i])
		maxSum = max(maxSum, currentMax)

		// Kadane's algorithm to find minimum subarray sum
		currentMin = min(nums[i], currentMin+nums[i])
		minSum = min(minSum, currentMin)
	}

	return max(abs(maxSum), abs(minSum))
}