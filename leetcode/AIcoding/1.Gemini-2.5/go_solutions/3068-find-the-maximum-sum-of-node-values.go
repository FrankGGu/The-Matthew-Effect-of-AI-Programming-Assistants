package main

import "math"

func maximumValueSum(nums []int, k int, edges [][]int) int64 {
	var totalSum int64 = 0
	flipCount := 0
	minPositiveDiff := math.MaxInt64 // Stores the smallest positive gain (diff > 0)
	maxNegativeDiff := math.MinInt64 // Stores the largest negative gain (diff <= 0, closest to 0)

	for _, num := range nums {
		originalVal := int64(num)
		flippedVal := int64(num ^ k)
		diff := flippedVal - originalVal

		totalSum += originalVal // Start by summing all original values

		if diff > 0 {
			totalSum += diff // Add this positive gain
			flipCount++
			if int(diff) < minPositiveDiff {
				minPositiveDiff = int(diff)
			}
		} else { // diff <= 0
			if int(diff) > maxNegativeDiff {
				maxNegativeDiff = int(diff)
			}
		}
	}

	if flipCount%2 == 0 {
		// If the count of nodes with positive gains is even,
		// we can take all these gains, and the total flip count is even.
		return totalSum
	} else {
		// If the count of nodes with positive gains is odd,
		// we need to adjust by one flip to make the total flip count even.
		// This means we must either:
		// 1. Revert one positive flip: Forgo the smallest positive gain.
		//    The cost is `minPositiveDiff`.
		// 2. Perform one negative flip: Take the largest negative gain (closest to zero).
		//    The cost is `-maxNegativeDiff` (since maxNegativeDiff is negative).
		// We choose the option that incurs the minimum penalty.

		var minPenalty int64 = math.MaxInt64

		// Option 1: Revert smallest positive flip
		if minPositiveDiff != math.MaxInt64 {
			minPenalty = int64(minPositiveDiff)
		}

		// Option 2: Take largest negative flip
		if maxNegativeDiff != math.MinInt64 {
			if -int64(maxNegativeDiff) < minPenalty {
				minPenalty = -int64(maxNegativeDiff)
			}
		}

		return totalSum - minPenalty
	}
}