func surfaceArea(grid [][]int) int {
	n := len(grid)
	area := 0
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] > 0 {
				area += 2
				area += grid[i][j]
				if i > 0 {
					area -= min(grid[i][j], grid[i-1][j])
				}
				if i < n-1 {
					area -= min(grid[i][j], grid[i+1][j])
				}
				if j > 0 {
					area -= min(grid[i][j], grid[i][j-1])
				}
				if j < n-1 {
					area -= min(grid[i][j], grid[i][j+1])
				}
			}
		}
	}
	return area
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}