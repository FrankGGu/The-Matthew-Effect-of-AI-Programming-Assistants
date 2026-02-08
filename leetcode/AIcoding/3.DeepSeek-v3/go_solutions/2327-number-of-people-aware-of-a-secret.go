func peopleAwareOfSecret(n int, delay int, forget int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n+1)
    dp[1] = 1
    for i := 2; i <= n; i++ {
        for j := max(1, i-forget+1); j <= i-delay; j++ {
            dp[i] = (dp[i] + dp[j]) % mod
        }
    }
    res := 0
    for i := max(1, n-forget+1); i <= n; i++ {
        res = (res + dp[i]) % mod
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}