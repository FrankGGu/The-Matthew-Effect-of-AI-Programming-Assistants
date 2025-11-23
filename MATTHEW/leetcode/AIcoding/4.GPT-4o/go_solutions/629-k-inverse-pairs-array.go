func kInversePairs(n int, k int) int {
    const mod = 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            for x := 0; x <= j && x < i; x++ {
                dp[i][j] = (dp[i][j] + dp[i-1][j-x]) % mod
            }
        }
    }
    return dp[n][k]
}