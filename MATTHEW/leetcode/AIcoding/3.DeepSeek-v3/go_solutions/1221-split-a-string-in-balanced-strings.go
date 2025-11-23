func balancedStringSplit(s string) int {
    balance := 0
    count := 0
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