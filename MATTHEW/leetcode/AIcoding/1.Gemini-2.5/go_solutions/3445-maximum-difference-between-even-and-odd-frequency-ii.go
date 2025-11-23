package main

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

func maximumDifferenceEvenOddFrequencyII(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	// Transform the array:
	// Assign 1 for odd numbers and -1 for even numbers.
	// The sum of a subarray in this transformed array will represent
	// (count of odd numbers - count of even numbers) in the original subarray.
	// We want to find the maximum absolute value of this difference.
	transformed := make([]int, len(nums))
	for i, num := range nums {
		if num%2 == 0 {
			transformed[i] = -1 // Even numbers contribute -1
		} else {
			transformed[i] = 1  // Odd numbers contribute 1
		}
	}

	// Kadane's algorithm to find the maximum subarray sum.
	// This finds the maximum possible value for (count_odd - count_even).
	maxSoFar := transformed[0]
	currentMax := transformed[0]
	for i := 1; i < len(transformed); i++ {
		currentMax = max(transformed[i], currentMax+transformed[i])
		maxSoFar = max(maxSoFar, currentMax)
	}

	// Kadane's algorithm variant to find the minimum subarray sum.
	// This finds the minimum (most negative) possible value for (count_odd - count_even).
	minSoFar := transformed[0]
	currentMin := transformed[0]
	for i := 1; i < len(transformed); i++ {
		currentMin = min(transformed[i], currentMin+transformed[i])
		minSoFar = min(minSoFar, currentMin)
	}

	// The maximum absolute difference is the maximum of the absolute values
	// of the maximum possible sum and the minimum possible sum.
	// For example, if max sum is 5 and min sum is -7, the max difference is 7.
	return max(abs(maxSoFar), abs(minSoFar))
}