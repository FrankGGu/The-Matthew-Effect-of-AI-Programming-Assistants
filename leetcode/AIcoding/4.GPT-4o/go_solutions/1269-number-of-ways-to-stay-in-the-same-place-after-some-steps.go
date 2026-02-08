func numWays(steps int, arrLen int) int {
    const mod = 1_000_000_007
    maxPos := min(arrLen-1, steps)
    dp := make([]int, maxPos+1)
    dp[0] = 1

    for i := 0; i < steps; i++ {
        nextDp := make([]int, maxPos+1)
        for j := 0; j <= maxPos; j++ {
            nextDp[j] = dp[j]
            if j > 0 {
                nextDp[j] = (nextDp[j] + dp[j-1]) % mod
            }
            if j < maxPos {
                nextDp[j] = (nextDp[j] + dp[j+1]) % mod
            }
        }
        dp = nextDp
    }

    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}