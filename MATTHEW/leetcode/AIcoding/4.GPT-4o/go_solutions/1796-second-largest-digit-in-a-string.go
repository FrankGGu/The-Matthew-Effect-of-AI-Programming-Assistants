func secondHighest(s string) int {
    first, second := -1, -1
    for _, char := range s {
        if char >= '0' && char <= '9' {
            digit := int(char - '0')
            if digit > first {
                second = first
                first = digit
            } else if digit > second && digit < first {
                second = digit
            }
        }
    }
    return second
}