func numIslands(grid [][]byte) int {
	if len(grid) == 0 {
		return 0
	}

	rows := len(grid)
	cols := len(grid[0])
	count := 0

	var dfs func(int, int)
	dfs = func(row, col int) {
		if row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == '0' {
			return
		}

		grid[row][col] = '0'
		dfs(row+1, col)
		dfs(row-1, col)
		dfs(row, col+1)
		dfs(row, col-1)
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if grid[i][j] == '1' {
				count++
				dfs(i, j)
			}
		}
	}

	return count
}