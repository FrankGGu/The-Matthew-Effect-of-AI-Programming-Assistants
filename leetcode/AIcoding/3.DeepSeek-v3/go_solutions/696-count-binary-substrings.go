func countBinarySubstrings(s string) int {
    var prev, curr, res int
    n := len(s)
    for i := 0; i < n; {
        curr = 1
        for i+1 < n && s[i] == s[i+1] {
            i++
            curr++
        }
        res += min(prev, curr)
        prev = curr
        i++
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}