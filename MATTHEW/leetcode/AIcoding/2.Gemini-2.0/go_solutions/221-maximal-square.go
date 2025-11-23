func maximalSquare(matrix [][]byte) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows := len(matrix)
    cols := len(matrix[0])
    dp := make([][]int, rows)
    for i := range dp {
        dp[i] = make([]int, cols)
    }

    maxSide := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if matrix[i][j] == '1' {
                if i == 0 || j == 0 {
                    dp[i][j] = 1
                } else {
                    dp[i][j] = min(min(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1]) + 1
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