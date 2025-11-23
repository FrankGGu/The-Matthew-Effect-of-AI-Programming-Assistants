func minRemoveToMakeValid(s string) string {
	runes := []rune(s)
	stack := []int{} // Stores indices of '('

	for i, r := range runes {
		if r == '(' {
			stack = append(stack, i)
		} else if r == ')' {
			if len(stack) > 0 {
				stack = stack[:len(stack)-1] // Pop
			} else {
				runes[i] = '*' // Mark this ')' for removal
			}
		}
	}

	for _, idx := range stack {
		runes[idx] = '*' // Mark remaining '(' for removal
	}

	var result []rune
	for _, r := range runes {
		if r != '*' {
			result = append(result, r)
		}
	}

	return string(result)
}