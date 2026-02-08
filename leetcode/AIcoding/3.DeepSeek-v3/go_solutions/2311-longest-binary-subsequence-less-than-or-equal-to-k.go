func longestSubsequence(s string, k int) int {
    n := len(s)
    res := 0
    sum := 0
    for i := n - 1; i >= 0; i-- {
        if s[i] == '0' {
            res++
        } else {
            if res < 30 && sum + (1 << res) <= k {
                sum += 1 << res
                res++
            }
        }
    }
    return res
}