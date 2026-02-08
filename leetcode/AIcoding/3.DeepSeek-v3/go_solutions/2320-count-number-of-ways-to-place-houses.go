func countHousePlacements(n int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n+1)
    if n == 0 {
        return 0
    }
    if n == 1 {
        return 4
    }
    dp[0] = 1
    dp[1] = 2
    for i := 2; i <= n; i++ {
        dp[i] = (dp[i-1] + dp[i-2]) % mod
    }
    return (dp[n] * dp[n]) % mod
}