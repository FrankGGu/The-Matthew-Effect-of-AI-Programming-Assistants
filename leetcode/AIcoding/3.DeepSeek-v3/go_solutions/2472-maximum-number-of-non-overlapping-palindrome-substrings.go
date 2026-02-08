func maxPalindromes(s string, k int) int {
    n := len(s)
    dp := make([]bool, n)
    res := 0
    for i := 0; i < n; i++ {
        for j := 0; j <= 1; j++ {
            l, r := i, i + j
            for l >= 0 && r < n && s[l] == s[r] {
                if r - l + 1 >= k && (l == 0 || !dp[l-1]) {
                    dp[r] = true
                    res++
                    break
                }
                l--
                r++
            }
        }
    }
    return res
}