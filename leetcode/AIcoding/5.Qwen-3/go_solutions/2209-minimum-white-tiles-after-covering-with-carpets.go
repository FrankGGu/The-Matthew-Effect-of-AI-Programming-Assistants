package main

func minimumWhiteTiles(tilePath string, carpetLen int) int {
    n := len(tilePath)
    dp := make([]int, n+1)
    for i := 0; i < n; i++ {
        dp[i+1] = dp[i] + (tilePath[i] == 'w')
    }
    for i := 0; i < n; i++ {
        if i+carpetLen <= n {
            dp[i+carpetLen] = min(dp[i+carpetLen], dp[i])
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