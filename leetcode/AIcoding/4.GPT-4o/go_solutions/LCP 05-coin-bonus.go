func maxCoins(bonus []int) int {
    n := len(bonus)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1]
        for j := 0; j < i; j++ {
            dp[i] = max(dp[i], dp[j]+bonus[i-1]*(i-j))
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