func reverseParentheses(s string) string {
    stack := make([][]byte, 0)
    var current []byte
    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            stack = append(stack, current)
            current = []byte{}
        } else if s[i] == ')' {
            for j, k := 0, len(current)-1; j < k; j, k = j+1, k-1 {
                current[j], current[k] = current[k], current[j]
            }
            if len(stack) > 0 {
                last := stack[len(stack)-1]
                stack = stack[:len(stack)-1]
                current = append(last, current...)
            }
        } else {
            current = append(current, s[i])
        }
    }
    return string(current)
}