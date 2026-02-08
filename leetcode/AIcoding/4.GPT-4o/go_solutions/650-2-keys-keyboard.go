func minSteps(n int) int {
    dp := make([]int, n+1)
    for i := 2; i <= n; i++ {
        dp[i] = i
        for j := 1; j*j <= i; j++ {
            if i%j == 0 {
                dp[i] = min(dp[i], dp[j]+i/j)
                if j != 1 {
                    dp[i] = min(dp[i], dp[i/j]+j)
                }
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