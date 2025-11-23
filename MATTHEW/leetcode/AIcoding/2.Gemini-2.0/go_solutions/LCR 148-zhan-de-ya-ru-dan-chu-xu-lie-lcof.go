func validateStackSequences(pushed []int, popped []int) bool {
	stack := []int{}
	i, j := 0, 0
	for i < len(pushed) {
		stack = append(stack, pushed[i])
		i++
		for len(stack) > 0 && stack[len(stack)-1] == popped[j] {
			stack = stack[:len(stack)-1]
			j++
		}
	}
	return len(stack) == 0
}