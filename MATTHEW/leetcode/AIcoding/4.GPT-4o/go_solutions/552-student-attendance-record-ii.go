func checkRecord(n int) int {
    const mod = 1_000_000_007
    dp := make([][3]int, n+1)
    dp[0] = [3]int{1, 0, 0}

    for i := 1; i <= n; i++ {
        dp[i][0] = (dp[i-1][0] + dp[i-1][1] + dp[i-1][2]) % mod
        dp[i][1] = dp[i-1][0]
        if i >= 2 {
            dp[i][2] = dp[i-2][0]
        }
    }

    result := (dp[n][0] + dp[n][1] + dp[n][2]) % mod
    return result
}