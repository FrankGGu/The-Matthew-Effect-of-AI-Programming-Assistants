func isValid(s string) bool {
	stack := []rune{}

	for _, char := range s {
		if char == 'a' || char == 'b' {
			stack = append(stack, char)
		} else if char == 'c' {
			if len(stack) >= 2 && stack[len(stack)-2] == 'a' && stack[len(stack)-1] == 'b' {
				stack = stack[:len(stack)-2]
			} else {
				return false
			}
		}
	}

	return len(stack) == 0
}