func maximumBobPoints(numArrows int, aliceArrows []int) []int {
	maxPoints := 0
	ans := make([]int, 12)

	// Initialize ans with all arrows in section 0, yielding 0 points.
	// This ensures a valid answer if no points can be scored by winning other sections.
	ans[0] = numArrows

	// Iterate through all possible combinations of sections Bob can win (from 1 to 11).
	// A bitmask represents which sections Bob wins.
	// The mask goes from 0 to 2^12 - 1.
	for mask := 0; mask < (1 << 12); mask++ {
		currentPoints := 0
		currentArrowsUsed := 0
		currentBobArrows := make([]int, 12) // Re-initialize for each mask combination

		// Check sections from 1 to 11.
		// Section 0 is handled by assigning remaining arrows later.
		for i := 1; i < 12; i++ {
			// If the i-th bit is set, Bob tries to win this section.
			if (mask>>i)&1 == 1 {
				arrowsNeeded := aliceArrows[i] + 1
				currentArrowsUsed += arrowsNeeded
				currentPoints += i
				currentBobArrows[i] = arrowsNeeded
			}
		}

		// If Bob has enough arrows for this combination of winning sections.
		if currentArrowsUsed <= numArrows {
			// Put all remaining arrows into section 0.
			currentBobArrows[0] = numArrows - currentArrowsUsed

			// If this combination yields more points, update the maximum points and the answer array.
			if currentPoints > maxPoints {
				maxPoints = currentPoints
				copy(ans, currentBobArrows)
			}
		}
	}

	return ans
}