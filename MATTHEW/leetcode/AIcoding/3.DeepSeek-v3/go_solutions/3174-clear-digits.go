func clearDigits(s string) string {
    stack := []rune{}
    for _, ch := range s {
        if ch >= '0' && ch <= '9' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, ch)
        }
    }
    return string(stack)
}