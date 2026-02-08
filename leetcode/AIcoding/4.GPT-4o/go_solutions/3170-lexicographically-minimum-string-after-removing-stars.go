func removeStars(s string) string {
    stack := []rune{}
    for _, char := range s {
        if char == '*' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, char)
        }
    }
    return string(stack)
}