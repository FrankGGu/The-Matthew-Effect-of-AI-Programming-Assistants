func countArrays(n int, k int) int {
    const mod = 1_000_000_007
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] * (k + 1) % mod
        if i > 1 {
            dp[i] = (dp[i] - dp[i-2]*k + mod) % mod
        }
    }
    return dp[n]
}