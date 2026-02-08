func rotateGrid(grid [][]int, k int) [][]int {
	m, n := len(grid), len(grid[0])
	layers := min(m, n) / 2

	for l := 0; l < layers; l++ {
		perimeter := 2 * (m - 2*l) + 2 * (n - 2*l) - 4
		rotations := k % perimeter

		for r := 0; r < rotations; r++ {
			temp := grid[l][l]

			// Move left to right on top row
			for j := l; j < n-l-1; j++ {
				grid[l][j] = grid[l][j+1]
			}

			// Move top to bottom on right column
			for i := l; i < m-l-1; i++ {
				grid[i][n-l-1] = grid[i+1][n-l-1]
			}

			// Move right to left on bottom row
			for j := n-l-1; j > l; j-- {
				grid[m-l-1][j] = grid[m-l-1][j-1]
			}

			// Move bottom to top on left column
			for i := m-l-1; i > l+1; i-- {
				grid[i][l] = grid[i-1][l]
			}

			grid[l+1][l] = temp
		}
	}

	return grid
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}