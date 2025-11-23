func scoreOfParentheses(s string) int {
    stack := []int{0}
    for _, c := range s {
        if c == '(' {
            stack = append(stack, 0)
        } else {
            last := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            if last == 0 {
                stack[len(stack)-1] += 1
            } else {
                stack[len(stack)-1] += 2 * last
            }
        }
    }
    return stack[0]
}