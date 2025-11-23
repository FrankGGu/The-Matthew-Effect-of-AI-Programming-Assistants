func countPowers(n int) int {
    const mod = 1e9 + 7
    maxBase := int(math.Pow(float64(n), 1/3.0))
    dp := make([]int, n+1)
    dp[0] = 1

    for base := 2; base <= maxBase; base++ {
        power := base * base * base
        for j := power; j <= n; j++ {
            dp[j] = (dp[j] + dp[j-power]) % mod
        }
    }

    return dp[n]
}