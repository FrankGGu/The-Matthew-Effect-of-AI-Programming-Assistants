func countDivisibleSubstrings(s string) int {
    n := len(s)
    totalCount := 0

    for j := 0; j < n; j++ {
        lastDigit := int(s[j] - '0')

        if lastDigit == 0 {
            // Division by zero