func scoreOfString(s string) int {
    stack := []int{0}
    for _, char := range s {
        if char == '(' {
            stack = append(stack, 0)
        } else {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            stack[len(stack)-1] += max(2*top, 1)
        }
    }
    return stack[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}