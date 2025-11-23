func checkGrid(grid [][]int) bool {
	m := len(grid)
	n := len(grid[0])

	for c := 0; c < n; c++ {
		for r := 0; r < m-1; r++ {
			if grid[r][c] != grid[r+1][c] {
				return false
			}
		}
	}

	for r := 0; r < m; r++ {
		for c := 0; c < n-1; c++ {
			if grid[r][c] >= grid[r][c+1] {
				return false
			}
		}
	}

	return true
}