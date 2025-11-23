func maximizeActiveSection(trades [][]int) int {
    n := len(trades)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j := 0; j < i; j++ {
            if trades[j][1] <= trades[i-1][0] {
                dp[i] = max(dp[i], dp[j]+trades[i-1][2])
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