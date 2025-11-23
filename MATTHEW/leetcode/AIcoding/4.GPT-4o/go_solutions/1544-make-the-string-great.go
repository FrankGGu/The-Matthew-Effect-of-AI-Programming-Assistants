func makeGood(s string) string {
	stack := []rune{}
	for _, ch := range s {
		if len(stack) > 0 && (stack[len(stack)-1] == ch+32 || stack[len(stack)-1] == ch-32) {
			stack = stack[:len(stack)-1]
		} else {
			stack = append(stack, ch)
		}
	}
	return string(stack)
}