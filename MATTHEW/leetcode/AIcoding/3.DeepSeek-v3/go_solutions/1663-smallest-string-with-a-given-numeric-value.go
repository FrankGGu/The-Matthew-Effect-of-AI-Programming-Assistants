func getSmallestString(n int, k int) string {
    res := make([]byte, n)
    for i := n - 1; i >= 0; i-- {
        add := min(26, k - i)
        res[i] = byte('a' + add - 1)
        k -= add
    }
    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}