func longestValidParentheses(s string) int {
	maxLen := 0
	stack := []int{-1} // Initialize stack with -1 to handle the base case of valid parentheses starting at index 0

	for i := 0; i < len(s); i++ {
		if s[i] == '(' {
			stack = append(stack, i)
		} else { // s[i] == ')'
			stack = stack[:len(stack)-1] // Pop the top element
			if len(stack) == 0 {
				stack = append(stack, i) // If stack becomes empty, push current index as a new base
			} else {
				currentLen := i - stack[len(stack)-1] // Calculate length from current index to the new top of stack
				if currentLen > maxLen {
					maxLen = currentLen
				}
			}
		}
	}
	return maxLen
}