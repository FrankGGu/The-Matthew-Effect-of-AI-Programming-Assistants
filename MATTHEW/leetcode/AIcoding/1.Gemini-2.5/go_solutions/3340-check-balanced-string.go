func isValid(s string) bool {
	stack := []rune{} // Using a slice as a stack

	// A map to store the corresponding closing bracket for each opening bracket
	bracketMap := map[rune]rune{
		'(': ')',
		'[': ']',
		'{': '}',
	}

	for _, char := range s {
		// If the character is an opening bracket, push it onto the stack
		if _, ok := bracketMap[char]; ok {
			stack = append(stack, char)
		} else { // If the character is a closing bracket
			// If the stack is empty, it means there's no corresponding opening bracket
			// for the current closing bracket, so the string is not balanced.
			if len(stack) == 0 {
				return false
			}

			// Pop the top element from the stack
			lastOpen := stack[len(stack)-1]
			stack = stack[:len(stack)-1]

			// Check if the popped opening bracket matches the current closing bracket
			if bracketMap[lastOpen] != char {
				return false // Mismatch found
			}
		}
	}

	// After iterating through the entire string, if the stack is empty,
	// it means all opening brackets have been matched. The string is balanced.
	// Otherwise, there are unmatched opening brackets, and the string is not balanced.
	return len(stack) == 0
}