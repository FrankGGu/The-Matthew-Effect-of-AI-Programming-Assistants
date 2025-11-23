func paintingPlan(n int, m int, k int) int {
    mod := 1000000007
    dp := make([]int, k+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            for l := k; l >= 1; l-- {
                dp[l] = (dp[l] + dp[l-1]*(j*(j-1)/2)%mod) % mod
            }
            for l := 1; l <= k; l++ {
                dp[l] = (dp[l] + dp[l-1]*i*(i-1)/2%mod) % mod
            }
        }
    }
    return dp[k]
}