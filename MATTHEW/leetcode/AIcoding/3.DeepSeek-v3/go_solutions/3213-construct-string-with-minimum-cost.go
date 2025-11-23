func minimumCost(s string) int64 {
    n := len(s)
    var res int64 = 0
    for i := 1; i < n; i++ {
        if s[i] != s[i-1] {
            res += int64(min(i, n-i))
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}