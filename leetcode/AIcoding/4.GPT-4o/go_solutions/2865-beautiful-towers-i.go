func beautifulTowers(n int, k int) int {
    if n == 1 {
        return 1
    }

    mod := 1_000_000_007
    dp := make([]int, n+1)
    dp[0] = 1
    dp[1] = k

    for i := 2; i <= n; i++ {
        dp[i] = (dp[i-1]*(k-1) + dp[i-2]*(k-1)) % mod
    }

    return dp[n]
}