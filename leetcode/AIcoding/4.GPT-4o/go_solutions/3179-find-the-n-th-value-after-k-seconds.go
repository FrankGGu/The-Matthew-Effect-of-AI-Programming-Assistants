func findNthValueAfterKSeconds(start int, k int, n int) int {
    return start + (k / n) * n + min(n, k % n)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}