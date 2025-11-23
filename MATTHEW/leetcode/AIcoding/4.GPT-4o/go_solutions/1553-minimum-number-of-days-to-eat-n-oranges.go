func minDays(n int) int {
    if n <= 0 {
        return 0
    }
    return 1 + min(minDays(n/2), minDays(n/3))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}