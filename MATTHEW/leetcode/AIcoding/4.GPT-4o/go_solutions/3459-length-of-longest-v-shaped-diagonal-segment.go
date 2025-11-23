func longestVShapeDiagonal(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    n, m := len(matrix), len(matrix[0])
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, m)
    }

    maxLength := 0

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            dp[i][j] = 1
            if i > 0 && j > 0 {
                dp[i][j] = max(dp[i][j], dp[i-1][j-1]+1)
            }
            if i > 0 && j < m-1 {
                dp[i][j] = max(dp[i][j], dp[i-1][j+1]+1)
            }
            maxLength = max(maxLength, dp[i][j])
        }
    }

    return maxLength
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}