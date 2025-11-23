func maximizeActiveSection(trades []int) int {
    n := len(trades)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j := 0; j < i; j++ {
            if trades[j] < trades[i-1] {
                dp[i] = max(dp[i], dp[j]+trades[i-1])
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