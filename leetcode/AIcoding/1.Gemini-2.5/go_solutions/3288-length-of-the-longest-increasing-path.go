func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows := len(matrix)
    cols := len(matrix[0])
    // dp[r][c] stores the length