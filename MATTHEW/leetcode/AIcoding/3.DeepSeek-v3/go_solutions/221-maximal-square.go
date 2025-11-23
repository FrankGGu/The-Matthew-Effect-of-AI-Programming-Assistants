func maximalSquare(matrix [][]byte) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }
    m, n := len(matrix), len(matrix[0])
    dp := make([][]int, m)
    maxSide := 0
    for i := 0; i < m; i++ {
        dp[i] = make([]int, n)
        for j := 0; j < n; j++ {
            if matrix[i][j] == '1' {
                if i == 0 || j == 0 {
                    dp[i][j] = 1
                } else {
                    dp[i][j] = min(dp[i-1][j], min(dp[i][j-1], dp[i-1][j-1])) + 1
                }
                if dp[i][j] > maxSide {
                    maxSide = dp[i][j]
                }
            }
        }
    }
    return maxSide * maxSide
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}