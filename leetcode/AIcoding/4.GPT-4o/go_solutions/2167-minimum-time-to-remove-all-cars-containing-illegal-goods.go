func minimumTime(s string) int {
    n := len(s)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + 1
        if s[i-1] == '1' {
            for j := i - 1; j >= 0 && i-j <= 3; j-- {
                dp[i] = min(dp[i], dp[j]+i-j-1)
            }
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}