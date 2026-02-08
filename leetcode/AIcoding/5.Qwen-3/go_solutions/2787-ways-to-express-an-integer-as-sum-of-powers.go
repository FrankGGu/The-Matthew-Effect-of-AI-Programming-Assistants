package main

func countIntegers(n int) int {
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 2; i <= n; i++ {
        for j := i; j <= n; j++ {
            dp[j] += dp[j-i]
        }
    }
    return dp[n]
}