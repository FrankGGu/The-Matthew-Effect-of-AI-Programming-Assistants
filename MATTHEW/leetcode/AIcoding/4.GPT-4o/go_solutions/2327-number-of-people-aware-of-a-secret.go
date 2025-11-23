func peopleAwareOfSecret(n int, delay int, forget int) int {
    mod := 1_000_000_007
    dp := make([]int, n+1)
    dp[1] = 1
    total := 0

    for i := 2; i <= n; i++ {
        if i-delay > 0 {
            dp[i] = (dp[i] + dp[i-delay]) % mod
        }
        if i-forget > 0 {
            dp[i] = (dp[i] - dp[i-forget] + mod) % mod
        }
        total = (total + dp[i]) % mod
    }

    return total
}