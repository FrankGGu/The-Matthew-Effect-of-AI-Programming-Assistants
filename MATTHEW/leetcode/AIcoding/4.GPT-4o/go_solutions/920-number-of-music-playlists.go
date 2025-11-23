func numMusicPlaylists(n int, m int, k int) int {
    const mod = 1_000_000_007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, m+1)
    }
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            dp[i][j] = (dp[i-1][j-1] * (n - i + 1)) % mod
            if j > k {
                dp[i][j] = (dp[i][j] + dp[i][j-1]*(i-k)) % mod
            }
        }
    }
    return dp[n][m]
}