func minAddToMakeValid(s string) int {
    balance := 0
    additions := 0

    for _, char := range s {
        if char == '(' {
            balance++
        } else if char == ')' {
            if balance > 0 {
                balance--
            } else {
                additions++
            }
        }
    }

    return balance + additions
}