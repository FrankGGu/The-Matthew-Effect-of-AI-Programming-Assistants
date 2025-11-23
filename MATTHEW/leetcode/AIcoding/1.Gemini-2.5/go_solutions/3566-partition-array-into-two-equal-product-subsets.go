package main

import (
	"math"
)

func canPartition(nums []int) bool {
	n := len(nums)
	if n < 2 {
		return false
	}

	// Step 1: Handle zeros
	zeroCount := 0
	for _, num := range nums {
		if num == 0 {
			zeroCount++
		}
	}

	if zeroCount == 1 {
		return false // One side will be 0, the other non-zero. Cannot be equal.
	}
	if zeroCount >= 2 {
		// If there are two or more zeros, we can always find a partition
		// such that each subarray contains at least one zero.
		// For example, find the index of the first zero (z1) and the last zero (z2).
		// Since zeroCount >= 2, z1 < z2.
		// We can partition at index i = z1.
		// The left subarray nums[0...z1] will contain nums[z1] (which is 0), so its product is 0.
		// The right subarray nums[z1+1...n-1] will contain nums[z2] (which is 0), so its product is 0.
		// Thus, both products are 0 and equal.
		return true
	}

	// Step 2: No zeros in the array. All elements are non-zero.
	// Use logarithm approach for magnitude comparison to avoid potential int64 overflow,
	// and count negatives for sign comparison.
	totalNegativeCount := 0
	totalLogSum := 0.0

	for _, num := range nums {
		if num < 0 {
			totalNegativeCount++
		}
		totalLogSum += math.Log(math.Abs(float64(num)))
	}

	leftNegativeCount := 0
	leftLogSum := 0.0
	epsilon := 1e-9 // Tolerance for float comparison

	for i := 0; i < n-1; i++ { // Iterate through all possible partition points
		num := nums[i]

		if num < 0 {
			leftNegativeCount++
		}
		leftLogSum += math.Log(math.Abs(float64(num)))

		rightNegativeCount := totalNegativeCount - leftNegativeCount
		rightLogSum := totalLogSum - leftLogSum

		// Check sign parity: both products must have the same sign
		if (leftNegativeCount%2) != (rightNegativeCount%2) {
			continue // Products have different signs
		}

		// Check magnitude: logarithms must be approximately equal
		if math.Abs(leftLogSum-rightLogSum) < epsilon {
			return true // Magnitudes are equal, and signs are equal
		}
	}

	return false // No such partition found
}