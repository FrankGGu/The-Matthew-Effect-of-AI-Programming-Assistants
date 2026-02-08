func longestValidParentheses(s string) int {
    maxLen := 0
    stack := []int{-1}

    for i, char := range s {
        if char == '(' {
            stack = append(stack, i)
        } else {
            stack = stack[:len(stack)-1]
            if len(stack) == 0 {
                stack = append(stack, i)
            } else {
                maxLen = max(maxLen, i-stack[len(stack)-1])
            }
        }
    }

    return maxLen
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}