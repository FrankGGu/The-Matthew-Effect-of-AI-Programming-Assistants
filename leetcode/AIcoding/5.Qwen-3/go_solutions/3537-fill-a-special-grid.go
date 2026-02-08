package main

func numberOfWays(n int) int {
    MOD := int(1e9 + 7)
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        if i >= 1 {
            dp[i] += dp[i-1]
        }
        if i >= 2 {
            dp[i] += dp[i-2]
        }
        dp[i] %= MOD
    }
    return dp[n]
}