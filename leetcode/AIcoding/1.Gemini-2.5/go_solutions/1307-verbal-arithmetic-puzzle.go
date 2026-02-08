func isSolvable(words []string, result string) bool {
	charToDigit := make(map[rune]int) // Maps character to assigned digit, -1 for unassigned
	digitUsed := [10]bool{}           // Tracks which digits are used
	leadingChars := make(map[rune]bool) // Tracks characters that are leading digits

	// Collect all unique characters and identify leading characters
	allChars := make(map[rune]bool)
	for _, word := range words {
		if len(word) > 1 {
			leadingChars[rune(word[0])] = true
		}
		for _, char := range word {
			allChars[char] = true
		}
	}
	if len(result) > 1 {
		leadingChars[rune(result[0])] = true
	}
	for _, char := range result {
		allChars[char] = true
	}

	// Initialize charToDigit for all unique characters to -1 (unassigned)
	// And populate uniqueChars slice for the order of assignment
	var uniqueChars []rune
	for char := range allChars {
		charToDigit[char] = -1 // Sentinel for unassigned
		uniqueChars = append(uniqueChars, char)
	}

	// If there are more than 10 unique characters, it's impossible to assign unique digits
	if len(uniqueChars) > 10 {
		return false
	}

	// Calculate coefficients for each character in the equation
	// The equation is sum(words) - result = 0
	// So, for each character, its coefficient is the sum of its positional values in words
	// minus its positional value in the result.
	coeffs := make(map[rune]int)
	for _, word := range words {
		power := 1
		for i := len(word) - 1; i >= 0; i-- {
			coeffs[rune(word[i])] += power
			power *= 10
		}
	}

	power := 1
	for i := len(result) - 1; i >= 0; i-- {
		coeffs[rune(result[i])] -= power
		power *= 10
	}

	// The backtracking function
	// idx: current index in uniqueChars slice to assign a digit to
	// currentSum: the running sum of (coefficient * assigned_digit) for characters processed so far
	var dfs func(idx int, currentSum int) bool
	dfs = func(idx int, currentSum int) bool {
		// Base case: All unique characters have been assigned digits
		if idx == len(uniqueChars) {
			// If the final sum is 0, a solution is found
			return currentSum == 0
		}

		char := uniqueChars[idx]

		// Try assigning each digit from 0 to 9 to the current character
		for digit := 0; digit <= 9; digit++ {
			// Pruning 1: Digit already used by another character
			if digitUsed[digit] {
				continue
			}
			// Pruning 2: Leading zero constraint
			if leadingChars[char] && digit == 0 {
				continue
			}

			// Assign digit
			charToDigit[char] = digit
			digitUsed[digit] = true

			// Recurse for the next character, updating the current sum
			if dfs(idx+1, currentSum+coeffs[char]*digit) {
				return true // Solution found
			}

			// Backtrack: Unassign digit and mark it as unused
			digitUsed[digit] = false
			charToDigit[char] = -1
		}
		return false // No digit works for the current character
	}

	// Start the backtracking process from the first unique character with an initial sum of 0
	return dfs(0, 0)
}