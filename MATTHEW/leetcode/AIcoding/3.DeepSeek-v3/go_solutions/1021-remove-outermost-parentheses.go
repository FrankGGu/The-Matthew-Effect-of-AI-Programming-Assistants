func removeOuterParentheses(S string) string {
    var result strings.Builder
    balance := 0
    start := 0

    for i, ch := range S {
        if ch == '(' {
            balance++
        } else {
            balance--
        }

        if balance == 0 {
            result.WriteString(S[start+1:i])
            start = i + 1
        }
    }

    return result.String()
}