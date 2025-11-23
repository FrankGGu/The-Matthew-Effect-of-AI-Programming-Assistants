func longestIncreasingPath(matrix [][]int) int {
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return 0
	}

	rows, cols := len(matrix), len(matrix[0])
	dp := make([][]int, rows)
	for i := range dp {
		dp[i] = make([]int, cols)
	}

	maxLen := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			maxLen = max(maxLen, dfs(matrix, i, j, dp))
		}
	}

	return maxLen
}

func dfs(matrix [][]int, row, col int, dp [][]int) int {
	if dp[row][col] != 0 {
		return dp[row][col]
	}

	rows, cols := len(matrix), len(matrix[0])
	directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
	maxPath := 1

	for _, dir := range directions {
		newRow, newCol := row+dir[0], col+dir[1]
		if newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && matrix[newRow][newCol] > matrix[row][col] {
			maxPath = max(maxPath, 1+dfs(matrix, newRow, newCol, dp))
		}
	}

	dp[row][col] = maxPath
	return maxPath
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}