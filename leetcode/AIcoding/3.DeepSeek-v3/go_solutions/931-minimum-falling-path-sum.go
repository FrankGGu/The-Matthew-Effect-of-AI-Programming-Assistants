func minFallingPathSum(matrix [][]int) int {
    n := len(matrix)
    if n == 1 {
        return matrix[0][0]
    }

    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, n)
        copy(dp[i], matrix[i])
    }

    for i := 1; i < n; i++ {
        for j := 0; j < n; j++ {
            minVal := dp[i-1][j]
            if j > 0 && dp[i-1][j-1] < minVal {
                minVal = dp[i-1][j-1]
            }
            if j < n-1 && dp[i-1][j+1] < minVal {
                minVal = dp[i-1][j+1]
            }
            dp[i][j] += minVal
        }
    }

    res := dp[n-1][0]
    for j := 1; j < n; j++ {
        if dp[n-1][j] < res {
            res = dp[n-1][j]
        }
    }
    return res
}