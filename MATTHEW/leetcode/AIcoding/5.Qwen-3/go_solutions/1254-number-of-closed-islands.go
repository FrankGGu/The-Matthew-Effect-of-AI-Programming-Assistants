package main

func closedIslands(grid [][]int) int {
	if len(grid) == 0 || len(grid[0]) == 0 {
		return 0
	}

	rows, cols := len(grid), len(grid[0])
	visited := make([][]bool, rows)
	for i := range visited {
		visited[i] = make([]bool, cols)
	}

	var dfs func(i, j int) bool
	dfs = func(i, j int) bool {
		if i < 0 || i >= rows || j < 0 || j >= cols {
			return false
		}
		if grid[i][j] == 0 && !visited[i][j] {
			visited[i][j] = true
			left := dfs(i, j-1)
			right := dfs(i, j+1)
			top := dfs(i-1, j)
			bottom := dfs(i+1, j)
			return left && right && top && bottom
		}
		return true
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