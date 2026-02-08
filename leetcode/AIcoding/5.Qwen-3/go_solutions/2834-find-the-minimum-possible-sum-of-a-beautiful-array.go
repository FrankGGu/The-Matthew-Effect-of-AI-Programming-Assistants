package main

func findMinPossibleSum(n int, k int) int {
    if n == 0 {
        return 0
    }
    dp := make([]int, n+1)
    dp[1] = 1
    for i := 2; i <= n; i++ {
        dp[i] = dp[i-1] + i
        if i-k >= 1 {
            dp[i] = min(dp[i], dp[i-k]+i)
        }
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}