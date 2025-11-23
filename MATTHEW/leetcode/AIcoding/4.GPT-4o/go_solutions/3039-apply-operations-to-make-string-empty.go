func canBeEmpty(s string) bool {
    stack := []rune{}
    for _, char := range s {
        if char == 'A' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, char)
        }
    }
    return len(stack) == 0
}