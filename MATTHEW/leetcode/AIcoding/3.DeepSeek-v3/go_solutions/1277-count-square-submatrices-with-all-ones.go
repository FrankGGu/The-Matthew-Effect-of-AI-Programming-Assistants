func countSquares(matrix [][]int) int {
    m := len(matrix)
    if m == 0 {
        return 0
    }
    n := len(matrix[0])
    dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
    }
    res := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == 1 {
                if i == 0 || j == 0 {
                    dp[i][j] = 1
                } else {
                    dp[i][j] = min(dp[i-1][j], min(dp[i][j-1], dp[i-1][j-1])) + 1
                }
                res += dp[i][j]
            }
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}