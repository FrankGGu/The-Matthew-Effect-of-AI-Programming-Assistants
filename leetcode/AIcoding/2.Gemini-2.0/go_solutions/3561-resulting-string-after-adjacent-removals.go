func removeDuplicates(s string) string {
	stack := []rune{}
	for _, r := range s {
		if len(stack) > 0 && stack[len(stack)-1] == r {
			stack = stack[:len(stack)-1]
		} else {
			stack = append(stack, r)
		}
	}
	return string(stack)
}