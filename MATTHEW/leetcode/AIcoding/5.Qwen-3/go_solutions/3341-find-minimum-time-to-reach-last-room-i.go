package main

func minTimeToReachLastRoom(rooms []int) int {
    n := len(rooms)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = rooms[i]
    }
    for i := 1; i < n; i++ {
        dp[i] = min(dp[i], dp[i-1]+1)
    }
    for i := n - 2; i >= 0; i-- {
        dp[i] = min(dp[i], dp[i+1]+1)
    }
    return dp[n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}