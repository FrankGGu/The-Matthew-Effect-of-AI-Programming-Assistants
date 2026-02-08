func backspaceCompare(s string, t string) bool {
    return buildString(s) == buildString(t)
}

func buildString(s string) string {
    stack := make([]byte, 0, len(s))
    for i := 0; i < len(s); i++ {
        char := s[i]
        if char == '#' {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, char)
        }
    }
    return string(stack)
}