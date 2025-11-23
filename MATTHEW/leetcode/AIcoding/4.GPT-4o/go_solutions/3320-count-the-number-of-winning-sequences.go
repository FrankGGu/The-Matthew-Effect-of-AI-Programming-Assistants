func countWinningSequences(n int, k int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n+1)
    dp[0] = 1

    for i := 1; i <= n; i++ {
        for j := 1; j <= k && j <= i; j++ {
            dp[i] = (dp[i] + dp[i-j]) % mod
        }
    }

    return dp[n]
}