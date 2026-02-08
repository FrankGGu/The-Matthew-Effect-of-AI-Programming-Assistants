func dfs(grid [][]int, r, c, rows, cols int) {
	// Base cases for DFS: out of bounds or already water/visited
	if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 1 {
		return
	}

	// Mark current cell as visited by changing it to water (1)
	grid[r][c] = 1

	// Explore neighbors
	dfs(grid, r+1, c, rows, cols)
	dfs(grid, r-1, c, rows, cols)
	dfs(grid, r, c+1, rows, cols)
	dfs(grid,