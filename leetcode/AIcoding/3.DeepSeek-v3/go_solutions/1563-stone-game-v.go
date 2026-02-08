func stoneGameV(stoneValue []int) int {
    n := len(stoneValue)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + stoneValue[i]
    }
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    for length := 1; length < n; length++ {
        for i := 0; i + length < n; i++ {
            j := i + length
            for k := i; k < j; k++ {
                leftSum := prefix[k+1] - prefix[i]
                rightSum := prefix[j+1] - prefix[k+1]
                if leftSum < rightSum {
                    dp[i][j] = max(dp[i][j], leftSum + dp[i][k])
                } else if leftSum > rightSum {
                    dp[i][j] = max(dp[i][j], rightSum + dp[k+1][j])
                } else {
                    dp[i][j] = max(dp[i][j], leftSum + max(dp[i][k], dp[k+1][j]))
                }
            }
        }
    }
    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}