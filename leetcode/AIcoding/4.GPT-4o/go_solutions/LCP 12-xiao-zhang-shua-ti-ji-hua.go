func minimumTime(n int, time []int) int {
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = int(1e9)
        for j := 0; j < i; j++ {
            dp[i] = min(dp[i], dp[j]+time[i-1]*(i-j))
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