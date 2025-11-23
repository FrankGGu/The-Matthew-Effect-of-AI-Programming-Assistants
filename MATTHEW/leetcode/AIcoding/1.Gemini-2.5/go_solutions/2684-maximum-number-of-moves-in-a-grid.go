package main

func maxMoves(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = -1 // -1 indicates not reachable
		}
	}

	for r := 0; r < m; r++ {
		dp[r][0] = 0 // Any cell in the first column can be a starting point with 0 moves
	}

	maxOverallMoves := 0

	for c := 0; c < n-1; c++ {
		canReachNextColumn := false // Flag to track if any cell in column c+1 was updated

		for r := 0; r < m; r++ {
			if dp[r][c] == -1 {
				continue // This cell is not reachable, so no moves can originate from it
			}

			// Possible moves: (r-1, c+1), (r, c+1), (r+1, c+1)
			for _, dr := range []int{-1, 0, 1} {
				nr := r + dr
				nc := c + 1

				if nr >= 0 && nr < m { // Check row bounds
					if grid[nr][nc] > grid[r][c] { // Check value condition
						if dp[r][c]+1 > dp[nr][nc] {
							dp[nr][nc] = dp[r][c] + 1
							canReachNextColumn = true // A cell in the next column was updated
						}

						if dp[nr][nc] > maxOverallMoves {
							maxOverallMoves = dp[nr][nc]
						}
					}
				}
			}
		}

		// Optimization: If no paths could be extended to the next column (c+1) from the current column (c)
		// by finding a longer path, then no further moves are possible from c+1 onwards either.
		if !canReachNextColumn {
			break
		}
	}

	return maxOverallMoves
}