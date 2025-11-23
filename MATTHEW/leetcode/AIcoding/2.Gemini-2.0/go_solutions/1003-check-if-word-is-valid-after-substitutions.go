func isValid(s string) bool {
	stack := []rune{}
	for _, char := range s {
		if char == 'c' {
			if len(stack) >= 2 && stack[len(stack)-1] == 'b' && stack[len(stack)-2] == 'a' {
				stack = stack[:len(stack)-2]
			} else {
				return false
			}
		} else {
			stack = append(stack, char)
		}
	}
	return len(stack) == 0
}