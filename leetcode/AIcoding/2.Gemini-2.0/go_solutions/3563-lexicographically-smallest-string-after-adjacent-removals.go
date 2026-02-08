func smallestString(s string) string {
	stack := []rune{}
	for _, c := range s {
		for len(stack) > 0 && c < stack[len(stack)-1] {
			stack = stack[:len(stack)-1]
		}
		stack = append(stack, c)
	}
	return string(stack)
}