func balancedStringSplit(s string) int {
    count, balance := 0, 0
    for _, char := range s {
        if char == 'L' {
            balance++
        } else {
            balance--
        }
        if balance == 0 {
            count++
        }
    }
    return count
}