func longestIncreasingPath(matrix [][]int) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    rows, cols := len(matrix), len(matrix[0])
    dp := make([][]int, rows)
    for i := range dp {
        dp[i] = make([]int, cols)
    }

    var dfs func(int, int) int
    dfs = func(r, c int) int {
        if dp[r][c] != 0 {
            return dp[r][c]
        }

        directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
        maxLength := 1

        for _, dir := range directions {
            nr, nc := r+dir[0], c+dir[1]
            if nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c] {
                maxLength = max(maxLength, 1+dfs(nr, nc))
            }
        }

        dp[r][c] = maxLength
        return maxLength
    }

    maxPath := 0
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            maxPath = max(maxPath, dfs(r, c))
        }
    }

    return maxPath
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}