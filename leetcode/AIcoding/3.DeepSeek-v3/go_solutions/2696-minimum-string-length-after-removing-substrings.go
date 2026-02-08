func minLength(s string) int {
    stack := []rune{}
    for _, c := range s {
        if len(stack) > 0 && ((stack[len(stack)-1] == 'A' && c == 'B') || (stack[len(stack)-1] == 'C' && c == 'D')) {
            stack = stack[:len(stack)-1]
        } else {
            stack = append(stack, c)
        }
    }
    return len(stack)
}