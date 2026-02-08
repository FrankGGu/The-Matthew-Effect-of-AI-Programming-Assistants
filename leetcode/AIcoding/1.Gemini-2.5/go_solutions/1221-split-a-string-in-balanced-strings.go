func balancedStringSplit(s string) int {
    balancedCount := 0
    lCount := 0
    rCount := 0

    for _, char := range s {
        if char == 'L' {
            lCount++
        } else {
            rCount++
        }

        if lCount == rCount {
            balancedCount++
            lCount = 0
            rCount = 0
        }
    }

    return balancedCount
}