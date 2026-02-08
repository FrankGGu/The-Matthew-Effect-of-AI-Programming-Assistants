func minLength(s string) int {
	stack := []byte{}

	for i := 0; i < len(s); i++ {
		char := s[i]
		if len(stack) > 0 {
			top := stack[len(stack)-1]
			if (top == 'A' && char == 'B') || (top == 'C' && char == 'D') {
				stack = stack[:len(stack)-1]
			} else {
				stack = append(stack, char)
			}
		} else {
			stack = append(stack, char)
		}
	}

	return len(stack)
}