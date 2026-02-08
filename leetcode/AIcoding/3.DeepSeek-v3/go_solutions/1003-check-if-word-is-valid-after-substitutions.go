func isValid(s string) bool {
    stack := []rune{}
    for _, c := range s {
        if c == 'c' {
            n := len(stack)
            if n < 2 || stack[n-1] != 'b' || stack[n-2] != 'a' {
                return false
            }
            stack = stack[:n-2]
        } else {
            stack = append(stack, c)
        }
    }
    return len(stack) == 0
}