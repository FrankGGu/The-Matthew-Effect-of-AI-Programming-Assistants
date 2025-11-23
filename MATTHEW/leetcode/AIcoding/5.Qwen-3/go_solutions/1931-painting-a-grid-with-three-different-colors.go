package main

func numberOfColors(n int) int {
    mod := 1000000007
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, 3)
    }
    dp[0][0] = 1
    dp[0][1] = 1
    dp[0][2] = 1
    for i := 1; i < n; i++ {
        dp[i][0] = (dp[i-1][1] + dp[i-1][2]) % mod
        dp[i][1] = (dp[i-1][0] + dp[i-1][2]) % mod
        dp[i][2] = (dp[i-1][0] + dp[i-1][1]) % mod
    }
    return (dp[n-1][0] + dp[n-1][1] + dp[n-1][2]) % mod
}