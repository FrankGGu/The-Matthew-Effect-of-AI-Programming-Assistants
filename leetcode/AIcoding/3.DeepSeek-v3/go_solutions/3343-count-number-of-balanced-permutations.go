func countBalancedPermutations(n int) int {
    if n == 1 {
        return 1
    }
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+2)
    }
    dp[1][0] = 1
    dp[1][1] = 1

    for i := 2; i <= n; i++ {
        for j := 0; j <= i; j++ {
            if j > 0 {
                dp[i][j] = (dp[i][j] + dp[i-1][j-1]) % (1e9 + 7)
            }
            if j < i {
                dp[i][j] = (dp[i][j] + dp[i-1][j+1]) % (1e9 + 7)
            }
        }
    }
    return dp[n][0]
}