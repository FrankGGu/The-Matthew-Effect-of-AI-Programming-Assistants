package main

import (
	"math"
)

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maximumSubarraySum(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	// Step 1: Find all unique elements in the array.
	uniqueElements := make(map[int]bool)
	for _, num := range nums {
		uniqueElements[num] = true
	}

	// Initialize globalMaxSum.
	// If all elements are removed (e.g., nums = [1,1,1] and we remove 1),
	// the resulting array is empty, and its maximum subarray sum is 0.
	// So, 0 is a valid baseline for the maximum sum.
	globalMaxSum := 0

	// Step 2: Iterate through each unique element to consider removing it.
	for uniqueVal := range uniqueElements {
		// Step 3: Create a new array by filtering out all occurrences of uniqueVal.
		filteredNums := make([]int, 0, len(nums))
		for _, num := range nums {
			if num != uniqueVal {
				filteredNums = append(filteredNums, num)
			}
		}

		// Step 4: Calculate the maximum subarray sum of the filtered array using Kadane's algorithm.
		if len(filteredNums) == 0 {
			// If all elements were removed, the max subarray sum is 0.
			globalMaxSum = max(globalMaxSum, 0)
		} else {
			// Kadane's algorithm:
			// maxSoFarForThisRemoval stores the maximum subarray sum found so far for the current filtered array.
			// currentMaxForThisRemoval stores the maximum subarray sum ending at the current position.
			maxSoFarForThisRemoval := filteredNums[0]
			currentMaxForThisRemoval := filteredNums[0]

			for i := 1; i < len(filteredNums); i++ {
				// The current subarray sum is either the current element itself,
				// or the current element added to the previous currentMax.
				currentMaxForThisRemoval = max(filteredNums[i], currentMaxForThisRemoval+filteredNums[i])
				// Update the overall maximum subarray sum found.
				maxSoFarForThisRemoval = max(maxSoFarForThisRemoval, currentMaxForThisRemoval)
			}
			// Update the global maximum sum across all unique element removals.
			globalMaxSum = max(globalMaxSum, maxSoFarForThisRemoval)
		}
	}

	// Step 5: Return the overall maximum sum found.
	return globalMaxSum
}