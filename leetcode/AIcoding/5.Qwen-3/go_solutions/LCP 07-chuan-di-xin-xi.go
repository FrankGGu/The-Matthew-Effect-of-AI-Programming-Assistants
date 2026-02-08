package main

func numWays(n int, k int) int {
    if n == 0 {
        return 0
    }
    if n == 1 {
        return k
    }
    dp := make([]int, n+1)
    dp[1] = k
    dp[2] = k * k
    for i := 3; i <= n; i++ {
        dp[i] = (dp[i-1] + dp[i-2]) * (k - 1)
    }
    return dp[n]
}