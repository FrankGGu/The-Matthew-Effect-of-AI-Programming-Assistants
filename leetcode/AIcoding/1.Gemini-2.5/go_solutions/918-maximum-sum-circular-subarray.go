import "math"

func maxSubarraySumCircular(nums []int) int {
	totalSum := 0
	maxSum := math.MinInt32 // Stores the maximum sum of a non-circular subarray
	currentMax := 0         // Current sum for max subarray
	minSum := math.MaxInt32 // Stores the minimum sum of a non-circular subarray
	currentMin := 0         // Current sum for min subarray

	for _, num := range nums {
		totalSum += num

		// Kadane's algorithm for maximum sum subarray
		currentMax += num
		maxSum = max(maxSum, currentMax)
		if currentMax < 0 {
			currentMax = 0
		}

		// Kadane's algorithm for minimum sum subarray
		currentMin += num
		minSum = min(minSum, currentMin)
		if currentMin > 0 {
			currentMin = 0
		}
	}

	if maxSum < 0 {
		return maxSum
	}

	return max(maxSum, totalSum-minSum)
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