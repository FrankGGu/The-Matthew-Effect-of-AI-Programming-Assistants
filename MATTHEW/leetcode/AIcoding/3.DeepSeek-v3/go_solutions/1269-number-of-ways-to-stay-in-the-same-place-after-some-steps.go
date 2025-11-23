func numWays(steps int, arrLen int) int {
    mod := 1000000007
    maxPos := steps
    if arrLen < maxPos {
        maxPos = arrLen
    }
    dp := make([][]int, steps+1)
    for i := range dp {
        dp[i] = make([]int, maxPos+2)
    }
    dp[0][0] = 1

    for i := 1; i <= steps; i++ {
        for j := 0; j < maxPos; j++ {
            dp[i][j] = dp[i-1][j]
            if j > 0 {
                dp[i][j] = (dp[i][j] + dp[i-1][j-1]) % mod
            }
            if j < maxPos-1 {
                dp[i][j] = (dp[i][j] + dp[i-1][j+1]) % mod
            }
        }
    }

    return dp[steps][0]
}