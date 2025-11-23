func removeStars(s string) string {
    stack := []rune{}
    for _, ch := range s {
        if ch == '*' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, ch)
        }
    }
    return string(stack)
}