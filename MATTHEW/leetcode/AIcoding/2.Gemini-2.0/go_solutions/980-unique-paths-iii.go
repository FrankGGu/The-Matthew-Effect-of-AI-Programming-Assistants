func uniquePathsIII(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	startRow, startCol := 0, 0
	emptySquares := 0

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 1 {
				startRow, startCol = i, j
			}
			if grid[i][j] == 0 {
				emptySquares++
			}
		}
	}

	count := 0
	var dfs func(row, col int, visited int)

	dfs = func(row, col int, visited int) {
		if row < 0 || row >= m || col < 0 || col >= n || grid[row][col] == -1 {
			return
		}

		if grid[row][col] == 2 {
			if visited == emptySquares+1 {
				count++
			}
			return
		}

		original := grid[row][col]
		grid[row][col] = -1

		dfs(row+1, col, visited+1)
		dfs(row-1, col, visited+1)
		dfs(row, col+1, visited+1)
		dfs(row, col-1, visited+1)

		grid[row][col] = original
	}

	dfs(startRow, startCol, 0)
	return count
}