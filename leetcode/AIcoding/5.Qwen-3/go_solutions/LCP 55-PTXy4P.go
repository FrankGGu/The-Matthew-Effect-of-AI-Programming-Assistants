package main

func minimumTime(n int, time []int) int {
    if n == 0 {
        return 0
    }
    dp := make([]int, n)
    dp[0] = time[0]
    for i := 1; i < n; i++ {
        dp[i] = dp[i-1] + time[i]
    }
    return dp[n-1]
}