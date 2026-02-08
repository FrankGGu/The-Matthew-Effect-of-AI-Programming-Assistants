package main

func pathFinder(maze string) bool {
	rows := 0
	for i := 0; i < len(maze); i++ {
		if maze[i] == '\n' {
			rows++
		}
	}
	if rows == 0 {
		return false
	}
	cols := (len(maze) + 1) / rows

	grid := make([][]byte, rows)
	for i := 0; i < rows; i++ {
		grid[i] = make([]byte, cols)
		copy(grid[i], maze[i*cols:(i+1)*cols])
	}

	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	var dfs func(int, int) bool
	dfs = func(r, c int) bool {
		if r < 0 || r >= rows || c < 0 || c >= cols || visited[r][c] || grid[r][c] == 'X' {
			return false
		}
		if grid[r][c] == 'B' {
			return true
		}
		visited[r][c] = true
		if dfs(r+1, c) || dfs(r-1, c) || dfs(r, c+1) || dfs(r, c-1) {
			return true
		}
		return false
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			if grid[i][j] == 'A' {
				return dfs(i, j)
			}
		}
	}
	return false
}