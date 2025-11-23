func largest1BorderedSquare(grid [][]int) int {
	n := len(grid)
	if n == 0 {
		return 0
	}
	m := len(grid[0])
	if m == 0 {
		return 0
	}

	maxSide := 0
	for side := min(n, m); side >= 1; side-- {
		for i := 0; i <= n-side; i++ {
			for j := 0; j <= m-side; j++ {
				if checkSquare(grid, i, j, side) {
					return side * side
				}
			}
		}
	}

	return maxSide
}

func checkSquare(grid [][]int, row, col, side int) bool {
	for i := 0; i < side; i++ {
		if grid[row][col+i] == 0 {
			return false
		}
		if grid[row+side-1][col+i] == 0 {
			return false
		}
		if grid[row+i][col] == 0 {
			return false
		}
		if grid[row+i][col+side-1] == 0 {
			return false
		}
	}
	return true
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}