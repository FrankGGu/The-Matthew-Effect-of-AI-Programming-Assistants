func countServers(grid [][]int) int {
	m := len(grid)
	if m == 0 {
		return 0
	}
	n := len(grid[0])
	if n == 0 {
		return 0
	}

	rowCount := make([]int, m)
	colCount := make([]int, n)

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				rowCount[r]++
				colCount[c]++
			}
		}
	}

	communicatingServers := 0

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 1 {
				if rowCount[r] > 1 || colCount[c] > 1 {
					communicatingServers++
				}
			}
		}
	}

	return communicatingServers
}