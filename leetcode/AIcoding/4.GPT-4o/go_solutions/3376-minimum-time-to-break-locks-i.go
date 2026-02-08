func minTimeToUnlock(locks []int) int {
    n := len(locks)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + locks[i-1]
        for j := 1; j < i; j++ {
            dp[i] = min(dp[i], dp[j]+locks[i-1])
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