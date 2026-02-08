package main

func peopleAwareOfSecret(n int, k int) int {
    MOD := 1000000007
    dp := make([]int, n)
    dp[0] = 1
    for i := 1; i < n; i++ {
        if i >= k {
            dp[i] = (dp[i] + dp[i-k]) % MOD
        }
        if i > 0 {
            dp[i] = (dp[i] + dp[i-1]) % MOD
        }
    }
    return dp[n-1]
}