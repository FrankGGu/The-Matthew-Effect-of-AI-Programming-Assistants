func kInversePairs(n int, k int) int {
    mod := 1000000007
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    dp[0][0] = 1
    for i := 1; i <= n; i++ {
        sum := 0
        for j := 0; j <= k; j++ {
            sum = (sum + dp[i-1][j]) % mod
            if j >= i {
                sum = (sum - dp[i-1][j-i] + mod) % mod
            }
            dp[i][j] = sum
        }
    }

    return dp[n][k]
}