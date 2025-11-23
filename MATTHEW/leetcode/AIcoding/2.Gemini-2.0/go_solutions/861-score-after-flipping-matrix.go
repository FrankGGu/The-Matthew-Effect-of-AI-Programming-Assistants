func matrixScore(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	for i := 0; i < m; i++ {
		if grid[i][0] == 0 {
			for j := 0; j < n; j++ {
				grid[i][j] ^= 1
			}
		}
	}

	for j := 0; j < n; j++ {
		count := 0
		for i := 0; i < m; i++ {
			if grid[i][j] == 0 {
				count++
			}
		}
		if count > m/2 {
			for i := 0; i < m; i++ {
				grid[i][j] ^= 1
			}
		}
	}

	ans := 0
	for i := 0; i < m; i++ {
		rowSum := 0
		for j := 0; j < n; j++ {
			rowSum = rowSum*2 + grid[i][j]
		}
		ans += rowSum
	}

	return ans
}