func maxValueOfCoins(piles [][]int, k int) int {
    n := len(piles)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, k+1)
    }

    for i := 1; i <= n; i++ {
        for j := 0; j <= k; j++ {
            dp[i][j] = dp[i-1][j]
            sum := 0
            for l := 1; l <= min(j, len(piles[i-1])); l++ {
                sum += piles[i-1][l-1]
                if dp[i][j] < dp[i-1][j-l]+sum {
                    dp[i][j] = dp[i-1][j-l] + sum
                }
            }
        }
    }
    return dp[n][k]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}