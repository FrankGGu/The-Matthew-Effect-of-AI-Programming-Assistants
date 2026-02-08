func minSwaps(s string) int {
    balance := 0
    maxBalance := 0

    for _, char := range s {
        if char == '[' {
            balance++
        } else {
            balance--
        }
        maxBalance = max(maxBalance, -balance)
    }

    return (maxBalance + 1) / 2
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}