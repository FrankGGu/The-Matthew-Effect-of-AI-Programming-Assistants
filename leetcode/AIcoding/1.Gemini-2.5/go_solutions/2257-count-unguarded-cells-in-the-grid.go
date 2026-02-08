func countUnguarded(m int, n int, guards [][]int, walls [][]int) int {
	grid := make([][]int, m)
	for i := range grid {
		grid[i] = make([]int, n)
	}

	// Mark walls (1)
	for _, wall := range walls {
		r, c := wall[0], wall[1]
		grid[r][c] = 1
	}

	// Mark guards (2)
	for _, guard := range guards {
		r, c := guard[0], guard[1]
		grid[r][c] = 2
	}

	// Directions: up, down, left, right
	dr := []int{-1, 1, 0, 0}
	dc := []int{0, 0, -1, 1}

	// Iterate through each cell to find guards and mark guarded cells
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 2 { // If it's a guard
				for i := 0; i < 4; i++ { // Check all 4 directions
					currR, currC := r+dr[i], c+dc[i]
					for currR >= 0 && currR < m && currC >= 0 && currC < n {
						// If we hit a wall or another guard, stop in this direction
						if grid[currR][currC] == 1 || grid[currR][currC] == 2 {
							break
						}
						// If it's an empty cell, mark it as guarded (3)
						if grid[currR][currC] == 0 {
							grid[currR][currC] = 3
						}
						// Move to the next cell in this direction
						currR += dr[i]
						currC += dc[i]
					}
				}
			}
		}
	}

	// Count unguarded cells (cells that are still 0)
	unguardedCount := 0
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if grid[r][c] == 0 {
				unguardedCount++
			}
		}
	}

	return unguardedCount
}