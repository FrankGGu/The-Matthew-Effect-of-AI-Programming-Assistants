func closedIsland(grid [][]int) int {
	rows, cols := len(grid), len(grid[0])
	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	var dfs func(row, col int) bool
	dfs = func(row, col int) bool {
		if row < 0 || row >= rows || col < 0 || col >= cols {
			return false
		}
		if grid[row][col] == 1 || visited[row][col] {
			return true
		}

		visited[row][col] = true
		isClosed := true
		isClosed = isClosed && dfs(row+1, col)
		isClosed = isClosed && dfs(row-1, col)
		isClosed = isClosed && dfs(row, col+1)
		isClosed = isClosed && dfs(row, col-1)

		return isClosed
	}

	count := 0
	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if grid[i][j] == 0 && !visited[i][j] {
				if dfs(i, j) {
					count++
				}
			}
		}
	}

	return count
}