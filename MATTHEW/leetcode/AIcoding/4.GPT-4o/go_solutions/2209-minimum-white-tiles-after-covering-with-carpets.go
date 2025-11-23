func minimumWhiteTiles(floor []int, numCarpets int, carpetLen int) int {
    n := len(floor)
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i-1] + floor[i-1]
    }

    for k := 1; k <= numCarpets; k++ {
        newDp := make([]int, n+1)
        for i := 0; i <= n; i++ {
            newDp[i] = dp[i]
            if i > 0 {
                newDp[i] = min(newDp[i], newDp[i-1])
            }
            if i >= carpetLen {
                newDp[i] = min(newDp[i], dp[i-carpetLen])
            }
        }
        dp = newDp
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}