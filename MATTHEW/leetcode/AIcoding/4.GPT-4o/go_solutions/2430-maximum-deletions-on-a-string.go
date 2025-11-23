func maximumDeletions(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + 1
        for j := 0; j < i-1; j++ {
            if s[j] == s[i-1] {
                dp[i] = max(dp[i], dp[j]+1)
            }
        }
    }
    return dp[n]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}