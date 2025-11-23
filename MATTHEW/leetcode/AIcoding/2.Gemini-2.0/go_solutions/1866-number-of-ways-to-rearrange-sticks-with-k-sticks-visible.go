func rearrangeSticks(n int, k int) int {
    const MOD = 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            dp[i][j] = (dp[i-1][j-1] + (i-1)*dp[i-1][j]%MOD) % MOD
        }
    }

    return dp[n][k]
}