func minimumTime(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        if s[i-1] == '1' {
            dp[i] = min(dp[i-1]+2, i)
        } else {
            dp[i] = dp[i-1]
        }
    }
    res := dp[n]
    for i := n - 1; i >= 0; i-- {
        if s[i] == '1' {
            dp[i] = min(dp[i+1]+2, n-i)
        } else {
            dp[i] = dp[i+1]
        }
        res = min(res, dp[i]+i)
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}