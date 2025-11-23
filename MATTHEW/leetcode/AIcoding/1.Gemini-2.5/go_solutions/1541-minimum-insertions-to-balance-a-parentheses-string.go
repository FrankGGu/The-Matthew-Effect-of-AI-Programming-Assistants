func minInsertions(s string) int {
	openCount := 0    // Tracks the number of open parentheses '(' that are currently unmatched
	insertions := 0 // Tracks the total number of insertions needed

	for i := 0; i < len(s); i++ {
		if s[i] == '(' {
			// If we encounter an open parenthesis, increment its count.
			openCount++
		} else { // s[i] == ')'
			// This ')' character is the first of a potential '))' pair.
			// It needs to match an open '('.
			if openCount > 0 {
				// An open '(' is available, so this ')' can match it.
				openCount--
			} else {
				// No open '(' available, we need to insert one.
				insertions++
			}

			// Now, we need to ensure this ')' forms a ')' pair.
			// Check if the next character is also ')'.
			if i+1 < len(s) && s[i+1] == ')' {
				// The next character is ')', so we have a ')).
				// Consume the second ')' by incrementing i.
				i++
			} else {
				// The current ')' does not have a pair immediately following it.
				// We need to insert a second ')' to form the pair.
				insertions++
			}
		}
	}

	// After iterating through the entire string, any remaining open parentheses
	// in 'openCount' still need to be closed. Each '(' requires two ')'s.
	insertions += openCount * 2

	return insertions
}