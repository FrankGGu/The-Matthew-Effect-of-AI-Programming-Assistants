package main

func getMaximumGold(grid [][]int) int {
	rows := len(grid)
	cols := len(grid[0])
	maxGold := 0

	var dfs func(r, c int) int
	dfs = func(r, c int) int {
		if r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0 {
			return 0
		}

		currentCellGold := grid[r][c]
		grid[r][c] = 0 // Mark as visited by setting to 0

		maxFromNeighbors := 0
		dirs := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}} // Up, Down, Left, Right

		for _, dir := range dirs {
			nr, nc := r+dir[0], c+dir[1]
			maxFromNeighbors = max(maxFromNeighbors, dfs(nr, nc))
		}

		grid[r][c] = currentCellGold // Backtrack: restore original value
		return currentCellGold + maxFromNeighbors
	}

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid[r][c] > 0 {
				maxGold = max(maxGold, dfs(r, c))
			}
		}
	}

	return maxGold
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}