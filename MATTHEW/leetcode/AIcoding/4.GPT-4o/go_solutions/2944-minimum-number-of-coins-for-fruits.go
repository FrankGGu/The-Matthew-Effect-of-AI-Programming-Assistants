func minCoins(fruits []int) int {
    n := len(fruits)
    if n == 0 {
        return 0
    }
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = 1 << 30
        for j := 0; j < i; j++ {
            if fruits[j] <= fruits[i-1] {
                dp[i] = min(dp[i], dp[j]+1)
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