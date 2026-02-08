func minLength(s string) int {
	stack := []rune{}
	for _, c := range s {
		if len(stack) > 0 {
			top := stack[len(stack)-1]
			if (top == 'A' && c == 'B') || (top == 'C' && c == 'D') {
				stack = stack[:len(stack)-1]
			} else {
				stack = append(stack, c)
			}
		} else {
			stack = append(stack, c)
		}
	}
	return len(stack)
}