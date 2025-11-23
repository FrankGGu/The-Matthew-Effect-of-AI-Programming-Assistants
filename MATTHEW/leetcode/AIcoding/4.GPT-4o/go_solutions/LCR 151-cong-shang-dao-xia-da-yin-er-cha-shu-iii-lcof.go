func numWays(n int) int {
    const mod = 1000000007
    if n == 0 {
        return 1
    }
    if n == 1 {
        return 2
    }
    dp := make([]int, n+1)
    dp[0], dp[1] = 1, 2
    for i := 2; i <= n; i++ {
        dp[i] = (dp[i-1] + dp[i-2]*2) % mod
    }
    return dp[n]
}