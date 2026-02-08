func maxProduct(s string) int {
    n := len(s)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }

    for i := 0; i < n; i++ {
        l, r := i, i
        for l >= 0 && r < n && s[l] == s[r] {
            dp[r] = max(dp[r], r-l+1)
            l--
            r++
        }
        l, r = i, i+1
        for l >= 0 && r < n && s[l] == s[r] {
            dp[r] = max(dp[r], r-l+1)
            l--
            r++
        }
    }

    ans := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if dp[i] > 1 && dp[j] > 1 {
                ans = max(ans, dp[i]*dp[j])
            }
        }
    }
    return ans
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}