package main

import (
	"math"
)

func minCostToCollectChocolates(chocolates []int, x int) int64 {
	n := len(chocolates)

	// minCosts[i] stores the minimum cost for the chocolate at logical position i.
	// This value is updated across different rotation counts.
	// Initially, for 0 rotations, the cost for position i is just chocolates[i].
	minCosts := make([]int64, n)
	initialChocolateSum := int64(0)
	for i := 0; i < n; i++ {
		minCosts[i] = int64(chocolates[i])
		initialChocolateSum += minCosts[i]
	}

	// Initialize the overall minimum total cost with the cost for 0 rotations.
	// This is the sum of initial chocolate costs plus 0 rotation cost.
	minOverallCost := initialChocolateSum

	// Iterate through possible number of rotations, from 1 to n-1.
	// Performing n rotations is equivalent to 0 rotations, so we only need to check up to n-1.
	for k := 1; k < n; k++ {
		currentChocolateSum := int64(0)

		// For each logical position i, update its minimum cost.
		// After k rotations, the chocolate that was originally at index (i-k+n)%n
		// is now at logical position i. Its cost is chocolates[(i-k+n)%n].
		// We take the minimum of the current minCost for position i (considering 0 to k-1 rotations)
		// and this new option (considering k rotations).
		for i := 0; i < n; i++ {
			// Calculate the original index of the chocolate that lands at position i after k rotations.
			originalIndex := (i - k + n) % n

			// Update the minimum cost for position i.
			// Use math.Min for int64 values.
			minCosts[i] = int64(math.Min(float64(minCosts[i]), float64(chocolates[originalIndex])))

			// Add this minimum cost to the sum for the current k rotations.
			currentChocolateSum += minCosts[i]
		}

		// Calculate the total cost for k rotations: sum of chocolate costs + cost of rotations.
		currentTotalCost := currentChocolateSum + int64(k)*int64(x)

		// Update the overall minimum total cost found so far.
		minOverallCost = int64(math.Min(float64(minOverallCost), float64(currentTotalCost)))
	}

	return minOverallCost
}