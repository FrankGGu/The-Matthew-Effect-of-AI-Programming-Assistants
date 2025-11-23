func differenceOfDistinctValues(grid [][]int) [][]int {
	m := len(grid)
	n := len(grid[0])
	result := make([][]int, m)
	for i := range result {
		result[i] = make([]int, n)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			topleft := make(map[int]bool)
			bottomright := make(map[int]bool)

			x, y := i - 1, j - 1
			for x >= 0 && y >= 0 {
				topleft[grid[x][y]] = true
				x--
				y--
			}

			x, y = i + 1, j + 1
			for x < m && y < n {
				bottomright[grid[x][y]] = true
				x++
				y++
			}

			result[i][j] = abs(len(topleft) - len(bottomright))
		}
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}