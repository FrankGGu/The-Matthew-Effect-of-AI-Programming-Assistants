func valueAfterKSeconds(n int, k int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = 1
    }
    for t := 1; t <= k; t++ {
        for i := 1; i < n; i++ {
            dp[i] = (dp[i] + dp[i-1]) % mod
        }
    }
    return dp[n-1]
}