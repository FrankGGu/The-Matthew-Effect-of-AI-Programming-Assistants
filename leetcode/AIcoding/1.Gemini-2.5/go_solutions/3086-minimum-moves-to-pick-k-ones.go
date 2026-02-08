package main

import (
	"math"
)

func minMoves(nums []int, k int) int64 {
	// Step 1: Find all indices of '1's in the nums array.
	var onesIndices []int
	for i, num := range nums {
		if num == 1 {
			onesIndices = append(onesIndices, i)
		}
	}

	numOnes := len(onesIndices)

	// Step 2: Transform indices to 'adjusted_pos'.
	// If we want to move k chosen ones (originally at positions x_0, x_1, ..., x_{k-1})
	// to occupy k consecutive cells (say, y, y+1, ..., y+k-1),
	// the total moves required is sum(|x_j - (y+j)|) for j from 0 to k-1.
	// This can be rewritten as sum(|(x_j - j) - y|).
	// Let z_j = x_j - j. We need to find y that minimizes sum(|z_j - y|).
	// The optimal y is the median of z_j values.
	// So, we create an array 'adjustedPos' where adjustedPos[j] = onesIndices[j] - j.
	adjustedPos := make([]int, numOnes)
	for i := 0; i < numOnes; i++ {
		adjustedPos[i] = onesIndices[i] - i
	}

	// Step 3: Calculate prefix sums for adjustedPos.
	// This allows efficient calculation of sum of elements within any window.
	prefixAdjustedPos := make([]int64, numOnes+1)
	for i := 0; i < numOnes; i++ {
		prefixAdjustedPos[i+1] = prefixAdjustedPos[i] + int64(adjustedPos[i])
	}

	minCost := int64(math.MaxInt64)

	// Step 4: Slide a window of size k over adjustedPos.
	// For each window, calculate the cost to make those k ones consecutive.
	// 'i' is the starting index of the window in 'adjustedPos'.
	for i := 0; i <= numOnes-k; i++ {
		// The current window in 'adjustedPos' is [i, i+k-1].
		// The median index within this window is 'midIdx'.
		midIdx := i + k/2
		medianVal := adjustedPos[midIdx]

		var currentCost int64

		// Calculate cost for elements to the left of the median (inclusive of median if k is odd)
		// The sum is (medianVal - adjustedPos[j]) for j from i to midIdx-1.
		// This is equivalent to (count of left elements) * medianVal - (sum of left elements).
		leftCount := int64(midIdx - i)
		leftSum := prefixAdjustedPos[midIdx] - prefixAdjustedPos[i]
		currentCost += leftCount*int64(medianVal) - leftSum

		// Calculate cost for elements to the right of the median
		// The sum is (adjustedPos[j] - medianVal) for j from midIdx+1 to i+k-1.
		// This is equivalent to (sum of right elements) - (count of right elements) * medianVal.
		rightCount := int64((i + k - 1) - midIdx)
		rightSum := prefixAdjustedPos[i+k] - prefixAdjustedPos[midIdx+1]
		currentCost += rightSum - rightCount*int64(medianVal)

		if currentCost < minCost {
			minCost = currentCost
		}
	}

	return minCost
}