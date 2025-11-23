func minLength(s string) int {
    stack := []rune{}
    for _, ch := range s {
        stack = append(stack, ch)
        if len(stack) >= 2 {
            if (stack[len(stack)-1] == 'B' && stack[len(stack)-2] == 'A') || (stack[len(stack)-1] == 'D' && stack[len(stack)-2] == 'C') {
                stack = stack[:len(stack)-2]
            }
        }
    }
    return len(stack)
}