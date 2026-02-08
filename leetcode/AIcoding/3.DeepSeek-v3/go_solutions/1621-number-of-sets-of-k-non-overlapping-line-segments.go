func numberOfSets(n int, k int) int {
    mod := 1000000007
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }
    sum := make([][]int, n)
    for i := range sum {
        sum[i] = make([]int, k+1)
    }

    dp[0][0] = 1
    sum[0][0] = 1

    for i := 1; i < n; i++ {
        dp[i][0] = 1
        sum[i][0] = (sum[i-1][0] + dp[i][0]) % mod
        for j := 1; j <= k; j++ {
            dp[i][j] = (dp[i-1][j] + sum[i-1][j-1]) % mod
            sum[i][j] = (sum[i-1][j] + dp[i][j]) % mod
        }
    }

    return dp[n-1][k]
}