func checkRecord(n int) int {
    const MOD = 1e9 + 7
    dp := make([][2][3]int, n+1)
    dp[0][0][0] = 1

    for i := 1; i <= n; i++ {
        for a := 0; a < 2; a++ {
            for l := 0; l < 3; l++ {
                // Add P
                dp[i][a][0] = (dp[i][a][0] + dp[i-1][a][l]) % MOD
                // Add A
                if a > 0 {
                    dp[i][a][0] = (dp[i][a][0] + dp[i-1][a-1][l]) % MOD
                }
                // Add L
                if l > 0 {
                    dp[i][a][l] = (dp[i][a][l] + dp[i-1][a][l-1]) % MOD
                }
            }
        }
    }

    res := 0
    for a := 0; a < 2; a++ {
        for l := 0; l < 3; l++ {
            res = (res + dp[n][a][l]) % MOD
        }
    }
    return res
}