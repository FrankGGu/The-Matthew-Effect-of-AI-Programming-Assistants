func scoreOfParentheses(s string) int {
    score := 0
    balance := 0

    for i := 0; i < len(s); i++ {
        if s[i] == '(' {
            balance++
        } else { // s[i] == ')'
            balance--
            // If the