func minimumWhiteTiles(floor string, numCarpets int, carpetLen int) int {
    n := len(floor)
    dp := make([][]int, numCarpets+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := 1; i <= n; i++ {
        dp[0][i] = dp[0][i-1] + int(floor[i-1] - '0')
    }

    for k := 1; k <= numCarpets; k++ {
        for i := 1; i <= n; i++ {
            if i <= carpetLen {
                dp[k][i] = 0
            } else {
                dp[k][i] = min(dp[k][i-1] + int(floor[i-1] - '0'), dp[k-1][i-carpetLen])
            }
        }
    }

    return dp[numCarpets][n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}