package main

import (
	"math"
)

func minimizeTheDifference(mat [][]int, target int) int {
	// Calculate the maximum possible sum.
	// m (number of rows) is up to 70.
	// Max element value is 70.
	// So, max possible sum = 70 * 70 = 4900.
	maxPossibleSum := len(mat) * 70

	// dp[j] will be true if sum j is reachable by choosing one element from each processed row.
	// Initialize dp with the sums from the first row.
	dp := make([]bool, maxPossibleSum+1)
	for _, val := range mat[0] {
		dp[val] = true
	}

	// Iterate through the remaining rows (from the second row onwards).
	for i := 1; i < len(mat); i++ {
		row := mat[i]
		newDp := make([]bool, maxPossibleSum+1) // Create a new DP array for sums after processing current row

		// Iterate through all possible sums 'j' that were reachable before this row.
		for j := 0; j <= maxPossibleSum; j++ {
			if dp[j] { // If sum 'j' was reachable
				// For each element 'val' in the current row, add it to 'j'
				// to form new reachable sums.
				for _, val := range row {
					if j+val <= maxPossibleSum { // Ensure the new sum is within bounds
						newDp[j+val] = true
					}
				}
			}
		}
		dp = newDp // Update dp for the next iteration
	}

	// After processing all rows, find the sum in dp that minimizes the absolute difference with target.
	minDiff := math.MaxInt32 // Initialize with a very large value

	for j := 0; j <= maxPossibleSum; j++ {
		if dp[j] { // If sum 'j' is reachable
			diff := j - target
			if diff < 0 {
				diff = -diff // Calculate absolute difference
			}
			if diff < minDiff {
				minDiff = diff
			}
		}
	}

	return minDiff
}