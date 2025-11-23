func countWays(n int) int {
    mod := 1_000_000_007
    if n == 1 {
        return 3
    }

    dp := make([]int, n+1)
    dp[1] = 3
    dp[2] = 6

    for i := 3; i <= n; i++ {
        dp[i] = (dp[i-1]*2 + dp[i-2]) % mod
    }

    return dp[n]
}