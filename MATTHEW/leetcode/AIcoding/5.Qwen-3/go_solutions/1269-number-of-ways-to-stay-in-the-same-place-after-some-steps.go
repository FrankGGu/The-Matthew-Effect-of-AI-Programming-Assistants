package main

func numWays(n int, steps int) int {
    MOD := 1000000007
    dp := make([][]int, steps+1)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    dp[0][0] = 1
    for i := 1; i <= steps; i++ {
        for j := 0; j < n; j++ {
            dp[i][j] = dp[i-1][j]
            if j > 0 {
                dp[i][j] += dp[i-1][j-1]
            }
            if j < n-1 {
                dp[i][j] += dp[i-1][j+1]
            }
            dp[i][j] %= MOD
        }
    }
    return dp[steps][0]
}