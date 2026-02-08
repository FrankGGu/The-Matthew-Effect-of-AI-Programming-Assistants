package main

func minTimeToReachLastRoom(rooms []int) int {
    n := len(rooms)
    dp := make([]int, n)
    for i := 0; i < n; i++ {
        dp[i] = rooms[i]
    }
    for i := 1; i < n; i++ {
        dp[i] = max(dp[i], dp[i-1]+1)
    }
    return dp[n-1]
}