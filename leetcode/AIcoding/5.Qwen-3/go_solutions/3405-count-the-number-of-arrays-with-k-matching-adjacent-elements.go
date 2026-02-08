package main

func colorTheArray(n int, k int) int {
    mod := int(1e9 + 7)
    dp := make([]int, n)
    dp[0] = 1
    for i := 1; i < n; i++ {
        dp[i] = (dp[i-1] * (k - 1)) % mod
    }
    return dp[n-1]
}