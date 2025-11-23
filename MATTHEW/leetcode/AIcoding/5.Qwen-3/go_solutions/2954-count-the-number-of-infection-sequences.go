package main

func numberOfInfectionSequences(n int) int {
    dp := make([]int, n+1)
    dp[0] = 1
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] * (i + 1)
    }
    return dp[n]
}