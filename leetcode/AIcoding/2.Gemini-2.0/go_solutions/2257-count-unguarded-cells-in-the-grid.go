func countUnguarded(m int, n int, guards [][]int, walls [][]int) int {
	grid := make([][]int, m)
	for i := range grid {
		grid[i] = make([]int, n)
	}

	for _, wall := range walls {
		grid[wall[0]][wall[1]] = 2
	}

	for _, guard := range guards {
		grid[guard[0]][guard[1]] = 3
	}

	for _, guard := range guards {
		row, col := guard[0], guard[1]

		// Left
		for c := col - 1; c >= 0; c-- {
			if grid[row][c] == 2 || grid[row][c] == 3 {
				break
			}
			grid[row][c] = 1
		}

		// Right
		for c := col + 1; c < n; c++ {
			if grid[row][c] == 2 || grid[row][c] == 3 {
				break
			}
			grid[row][c] = 1
		}

		// Up
		for r := row - 1; r >= 0; r-- {
			if grid[r][col] == 2 || grid[r][col] == 3 {
				break
			}
			grid[r][col] = 1
		}

		// Down
		for r := row + 1; r < m; r++ {
			if grid[r][col] == 2 || grid[r][col] == 3 {
				break
			}
			grid[r][col] = 1
		}
	}

	unguarded := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 0 {
				unguarded++
			}
		}
	}

	return unguarded
}