package main

func checkRecord(n int) int {
    MOD := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 2)
    }
    dp[0][0] = 1
    dp[0][1] = 0
    for i := 1; i <= n; i++ {
        dp[i][0] = (dp[i-1][0] + dp[i-1][1]) % MOD
        dp[i][1] = (dp[i-1][0] + dp[i-1][1]) % MOD
        if i >= 2 {
            dp[i][1] = (dp[i][1] + dp[i-2][0]) % MOD
        }
        if i >= 3 {
            dp[i][1] = (dp[i][1] + dp[i-3][0]) % MOD
        }
    }
    return (dp[n][0] + dp[n][1]) % MOD
}