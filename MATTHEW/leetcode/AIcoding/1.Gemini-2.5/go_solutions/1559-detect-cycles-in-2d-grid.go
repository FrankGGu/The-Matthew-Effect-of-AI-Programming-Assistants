func hasCycle(grid [][]byte) bool {
	m := len(grid)
	n := len(grid[0])

	// 0: unvisited, 1: visiting (in current DFS path), 2: visited (fully processed)
	colors := make([][]int, m)
	for i := range colors {
		colors[i] = make([]int, n)
	}

	// Directions for moving (right, left, down, up)
	dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

	var dfs func(r, c, pr, pc int, targetChar byte) bool
	dfs = func(r, c, pr, pc int, targetChar byte) bool {
		colors[r][c] = 1 // Mark current cell as visiting

		for _, dir := range dirs {
			nr, nc := r+dir[0], c+dir[1]

			// Skip if neighbor is the parent cell (to avoid going back immediately)
			if nr == pr && nc == pc {
				continue
			}

			// Check bounds and character match
			if nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] == targetChar {
				if colors[nr][nc] == 1 {
					// Found a neighbor that is currently in the recursion stack (visiting)
					// This indicates a cycle.
					return true
				}
				if colors[nr][nc] == 0 {
					// If neighbor is unvisited, recurse
					if dfs(nr, nc, r, c, targetChar) {
						return true
					}
				}
			}
		}

		colors[r][c] = 2 // Mark current cell as fully visited (processed)
		return false
	}

	// Iterate through all cells to ensure all connected components are checked
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if colors[i][j] == 0 { // If cell is unvisited, start a new DFS
				// Initial parent coordinates are -1, -1 as no parent exists for the starting node
				if dfs(i, j, -1, -1, grid[i][j]) {
					return true
				}
			}
		}
	}

	return false
}