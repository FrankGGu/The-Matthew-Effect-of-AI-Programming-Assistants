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
    dfs = func(x, y int) int {
        if dp[x][y] != 0 {
            return dp[x][y]
        }

        directions := [][2]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
        maxLength := 1

        for _, dir := range directions {
            newX, newY := x + dir[0], y + dir[1]
            if newX >= 0 && newX < rows && newY >= 0 && newY < cols && matrix[newX][newY] > matrix[x][y] {
                length := 1 + dfs(newX, newY)
                maxLength = max(maxLength, length)
            }
        }

        dp[x][y] = maxLength
        return maxLength
    }

    maxPath := 0
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            maxPath = max(maxPath, dfs(i, j))
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