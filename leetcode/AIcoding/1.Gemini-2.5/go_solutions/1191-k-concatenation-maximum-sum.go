package main

import "math"

func kadane(arr []int) int {
	if len(arr) == 0 {
		return 0 // Should not happen based on problem constraints (arr.length >= 1)
	}

	maxSoFar := arr[0]
	currentMax := arr[0]

	for i := 1; i < len(arr); i++ {
		currentMax = max(arr[i], currentMax+arr[i])
		maxSoFar = max(maxSoFar, currentMax)
	}
	return maxSoFar
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func kConcatenationMaxSum(arr []int, k int) int {
	MOD := 1_000_000_007

	n := len(arr)

	// 1. Calculate max subarray sum for a single array (Kadane's)
	// This handles cases where the max subarray is entirely within one block.
	maxSubarraySumSingle := kadane(arr)

	// 2. Calculate total sum of the array
	totalSum := 0
	for _, x := range arr {
		totalSum += x
	}

	// 3. Calculate max subarray sum for two concatenated arrays (arr + arr)
	// This is needed for k > 1 and totalSum <= 0, or as a base for totalSum > 0.
	// Create arr2x = arr + arr
	arr2x := make([]int, 2*n)
	copy(arr2x, arr)
	copy(arr2x[n:], arr)
	maxSubarraySumDouble := kadane(arr2x)

	// Final Result Logic
	var result int
	if k == 1 {
		result = maxSubarraySumSingle
	} else { // k > 1
		if totalSum <= 0 {
			// If totalSum is not positive, adding more full blocks won't help.
			// The max sum will be either within one block or span at most two blocks.
			// maxSubarraySumDouble already covers maxSubarraySumSingle.
			result = maxSubarraySumDouble
		} else { // totalSum > 0
			// If totalSum is positive, we can potentially benefit from (k-2) full blocks.
			// maxSubarraySumDouble accounts for the best sum in arr+arr.
			// We add (k-2) * totalSum for the middle blocks.
			// This calculation needs to be done with int64 to avoid overflow before modulo.
			result64 := (int64(maxSubarraySumDouble) + int64(k-2)*int64(totalSum))
			result = int(result64)
		}
	}

	// Apply modulo and ensure non-negative result
	finalResult := result % MOD
	if finalResult < 0 {
		finalResult += MOD
	}
	return finalResult
}