func countWays(n int, k int) int {
    if n == 0 {
        return 1
    }
    if n == 1 {
        return k
    }
    if n == 2 {
        return k * (k - 1)
    }

    mod := int(1e9 + 7)
    dp := make([]int, n+1)
    dp[1] = k
    dp[2] = k * (k - 1) % mod

    for i := 3; i <= n; i++ {
        dp[i] = (dp[i-1]*(k-1) + dp[i-2]*(k-1)) % mod
    }

    return dp[n]
}