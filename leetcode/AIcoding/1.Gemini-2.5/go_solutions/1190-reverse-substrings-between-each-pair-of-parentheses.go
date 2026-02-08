func reverseParentheses(s string) string {
    stack := [][]byte{}
    current := []byte{}

    for i := 0; i < len(s); i++ {
        char := s[i]
        if char == '(' {
            stack = append(stack, current)
            current = []byte{}
        } else