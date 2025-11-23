package main

var B int

var memo map[int]map[[9]int]int

func solve(counts [9]int, currentBatchRem int) int {
	// Check memoization table for existing result
	if _, ok := memo[currentBatchRem]; ok {
		if val, ok := memo[currentBatchRem][counts]; ok {
			return val
		}
	}

	maxAdditionalGroups := 0

	if currentBatchRem == 0 { // A new fresh batch is starting
		// Try to pick any available group (with remainder r > 0) to start this fresh batch.
		// This group will get fresh donuts.
		for r := 1; r < B; r++ {
			if counts[r] > 0 {
				counts[r]-- // Temporarily decrement count for this choice

				// This group gets fresh donuts, so add 1 to the result.
				// Calculate the remaining donuts in the current batch after this group takes its share.
				// (B - r + B) % B ensures the result is always non-negative and within [0, B-1].
				res := 1 + solve(counts, (B-r+B)%B)

				counts[r]++ // Backtrack: restore count for other choices
				if res > maxAdditionalGroups {
					maxAdditionalGroups = res
				}
			}
		}
		// If no group can be picked (all counts[r] are 0 for r > 0),
		// then maxAdditionalGroups remains 0. This is the base case for this branch.
	} else { // Continuing an existing batch
		// Try to pick any available group (with remainder r > 0) to continue this batch.
		// This group will NOT get fresh donuts.
		for r := 1; r < B; r++ {
			if counts[r] > 0 {
				counts[r]-- // Temporarily decrement count

				// Calculate the remaining donuts in the current batch after this group takes its share.
				// (currentBatchRem - r + B) % B handles cases where currentBatchRem - r might be negative,
				// ensuring the result is non-negative and within [0, B-1].
				nextBatchRem := (currentBatchRem - r + B) % B
				res := solve(counts, nextBatchRem)

				counts[r]++ // Backtrack
				if res > maxAdditionalGroups {
					maxAdditionalGroups = res
				}
			}
		}
		// If no group can be picked, we cannot continue this batch.
		// The current path ends here. maxAdditionalGroups remains 0 for this path.
	}

	// Store the computed result in the memoization table
	if memo[currentBatchRem] == nil {
		memo[currentBatchRem] = make(map[[9]int]int)
	}
	memo[currentBatchRem][counts] = maxAdditionalGroups
	return maxAdditionalGroups
}

func maxGroups(batchSize int, groups []int) int {
	B = batchSize // Set global batchSize

	// initialCounts will store the frequency of each remainder (1 to B-1).
	// Max batchSize is 9, so an array of size 9 is sufficient for indices 0-8.
	var initialCounts [9]int

	initialAns := 0 // Stores groups that definitely get fresh donuts.

	// First, process groups that need a multiple of batchSize donuts (remainder 0).
	// These groups always get fresh donuts if they are processed first in their own fresh batch.
	// They don't affect the remainder logic for other groups.
	for _, g := range groups {
		r := g % B
		if r == 0 {
			initialAns++
		} else {
			initialCounts[r]++
		}
	}

	// Optimization: If a remainder 'r' has 'k * B + x' groups,
	// 'k * B' groups can be processed in 'k' cycles of 'B' groups each.
	// Each such cycle will result in 1 group getting fresh donuts (the first one in the cycle).
	// The remaining 'x' groups are what truly matter for the DP state.
	// So, we add 'k' to initialAns and reduce initialCounts[r] to 'x'.
	for r := 1; r < B; r++ {
		initialAns += initialCounts[r] / B
		initialCounts[r] %= B
	}

	// Initialize memoization table for the current test case.
	memo = make(map[int]map[[9]int]int)

	// Start the recursive DP with the optimized counts and a fresh batch (currentBatchRem = 0).
	return initialAns + solve(initialCounts, 0)
}