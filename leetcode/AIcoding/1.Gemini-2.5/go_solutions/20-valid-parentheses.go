func isValid(s string) bool {
    stack := make([]rune, 0)

    bracketMap := map[rune]rune{
        '(': ')',
        '{': '}',
        '[': ']',
    }

    for _, char := range s {
        if _, ok := bracketMap[char]; ok {
            stack = append(stack, char)
        } else {
            if len(stack) == 0 {
                return false
            }

            lastOpen := stack[len(stack)-1]
            stack = stack[:len(stack)-1]

            if bracketMap[lastOpen] != char {
                return false
            }
        }
    }

    return len(stack) == 0
}