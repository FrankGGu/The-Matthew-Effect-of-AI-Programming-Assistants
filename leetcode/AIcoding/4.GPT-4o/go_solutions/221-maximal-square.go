func maximalSquare(matrix [][]byte) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    dp := make([]int, cols+1)
    maxSide := 0
    prev := 0

    for i := 1; i <= rows; i++ {
        for j := 1; j <= cols; j++ {
            if matrix[i-1][j-1] == '1' {
                temp := dp[j]
                dp[j] = min(dp[j], min(dp[j-1], prev)) + 1
                maxSide = max(maxSide, dp[j])
                prev = temp
            } else {
                prev = dp[j]
                dp[j] = 0
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

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}