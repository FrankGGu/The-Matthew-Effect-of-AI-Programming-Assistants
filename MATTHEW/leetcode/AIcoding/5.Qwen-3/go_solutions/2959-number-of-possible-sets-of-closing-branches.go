package main

func numberOfSets(n int, k int) int {
    mod := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    for i := 0; i <= n; i++ {
        dp[i][0] = 1
    }
    for i := 1; i <= n; i++ {
        for j := 1; j <= k; j++ {
            dp[i][j] = (dp[i-1][j] + dp[i-1][j-1]) % mod
        }
    }
    return dp[n][k]
}