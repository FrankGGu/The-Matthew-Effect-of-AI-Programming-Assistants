func checkValidString(s string) bool {
	minOpen := 0
	maxOpen := 0

	for _, char := range s {
		if char == '(' {
			minOpen++
			maxOpen++
		} else if char == ')' {
			minOpen--
			maxOpen--
		} else { // char == '*'
			minOpen-- // Treat '*' as ')' to minimize open count
			maxOpen++ // Treat '*' as '(' to maximize open count
		}

		// minOpen cannot be negative. If it is, it means we had to use '*' as ')'
		// but still ended up with more ')' than '('. We can cap it at 0.
		if minOpen < 0 {
			minOpen = 0
		}

		// If maxOpen ever becomes negative, it means we have too many ')'
		// even if all '*' were treated as '('. So, it's an invalid string.
		if maxOpen < 0 {
			return false
		}
	}

	// For the string to be valid, the minimum number of open parentheses
	// that must exist at the end should be 0.
	return minOpen == 0
}