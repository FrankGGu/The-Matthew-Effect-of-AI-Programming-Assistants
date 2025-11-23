func generateParenthesis(n int) []string {
	result := []string{}

	// backtrack is a recursive helper function
	// current: the current string of parentheses being built
	// open: the number of open parentheses used so far
	// close: the number of close parentheses used so far
	var backtrack func(current string, open, close int)
	backtrack = func(current string, open, close int) {
		// Base case: If the current string length is 2*n, it's a complete combination
		// and must be well-formed due to the conditions below.
		if len(current) == 2*n {
			result = append(result, current)
			return
		}

		// Recursive step 1: Add an opening parenthesis
		// We can add an open parenthesis if we haven't used all 'n' allowed open parentheses.
		if open < n {
			backtrack(current + "(", open + 1, close)
		}

		// Recursive step 2: Add a closing parenthesis
		// We can add a close parenthesis only if the number of closing parentheses
		// is less than the number of opening parentheses. This ensures that the
		// parentheses are well-formed (e.g., we never have a ')' without a preceding '(').
		if close < open {
			backtrack(current + ")", open, close + 1)
		}
	}

	// Start the backtracking process with an empty string and zero counts
	backtrack("", 0, 0)

	return result
}