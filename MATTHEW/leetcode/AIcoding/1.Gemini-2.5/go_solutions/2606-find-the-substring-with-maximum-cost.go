package main

import "math"

func maximumCostSubstring(s string, chars string, vals []int) int {
	charCosts := [26]int{}

	// Initialize default costs for 'a' through 'z'
	for i := 0; i < 26; i++ {
		charCosts[i] = i + 1 // 'a' is 0+1=1, 'b' is 1+1=2, etc.
	}

	// Override costs based on the 'chars' and 'vals' arrays
	for i := 0; i < len(chars); i++ {
		charIndex := chars[i] - 'a'
		charCosts[charIndex] = vals[i]
	}

	maxCost := math.MinInt32 // Stores the maximum cost found so far
	currentCost := 0         // Stores the cost of the current substring ending at the current position

	// Apply Kadane's algorithm
	for i := 0; i < len(s); i++ {
		charIndex := s[i] - 'a'
		cost := charCosts[charIndex]

		currentCost += cost

		// Update the overall maximum cost
		if currentCost > maxCost {
			maxCost = currentCost
		}

		// If currentCost becomes negative, reset it to 0.
		// A negative sum will only decrease the sum of any future substring,
		// so it's better to start a new substring from the next character.
		if currentCost < 0 {
			currentCost = 0
		}
	}

	return maxCost
}