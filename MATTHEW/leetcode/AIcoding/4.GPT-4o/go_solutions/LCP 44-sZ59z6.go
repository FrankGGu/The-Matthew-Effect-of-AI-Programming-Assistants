func numOfWays(n int, a []int) int {
    mod := 1_000_000_007
    dp := make([][3]int, n+1)
    dp[0][0] = 1

    for i := 1; i <= n; i++ {
        for j := 0; j < 3; j++ {
            dp[i][j] = dp[i-1][(j+1)%3] + dp[i-1][(j+2)%3]
            dp[i][j] %= mod
        }
    }

    return (dp[n][0] + dp[n][1] + dp[n][2]) % mod
}