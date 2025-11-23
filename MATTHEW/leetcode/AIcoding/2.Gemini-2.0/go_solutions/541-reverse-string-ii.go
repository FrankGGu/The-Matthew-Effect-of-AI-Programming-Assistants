func reverseStr(s string, k int) string {
    n := len(s)
    res := []rune(s)
    for i := 0; i < n; i += 2 * k {
        l := i
        r := min(i+k-1, n-1)
        for l < r {
            res[l], res[r] = res[r], res[l]
            l++
            r--
        }
    }
    return string(res)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}