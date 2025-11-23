import "math"

func maxSubarraySumCircular(nums []int) int {
	maxSoFar := nums[0]
	maxEndingHere := nums[0]
	minSoFar := nums[0]
	minEndingHere := nums[0]
	totalSum := nums[0]

	for i := 1; i < len(nums); i++ {
		totalSum += nums[i]

		maxEndingHere = max(nums[i], maxEndingHere+nums[i])
		maxSoFar = max(maxSoFar, maxEndingHere)

		minEndingHere = min(nums[i], minEndingHere+nums[i])
		minSoFar = min(minSoFar, minEndingHere)
	}

	if maxSoFar > 0 {
		return max(maxSoFar, totalSum-minSoFar)
	}

	return maxSoFar
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