package main

func maxMovesToKillAllPawns(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = -1 // Initialize with -1 to indicate unreachable
		}
	}

	// Base cases: any cell in the first column can be a starting point
	// if it's a pawn (1). 0 moves to start.
	for r := 0; r < m; r++ {
		if grid[r][0] == 1 {
			dp[r][0] = 0
		}
	}

	maxTotalMoves := 0

	// Iterate column by column
	for c := 0; c < n-1; c++ { // Iterate up to n-2 because we move to c+1
		for r := 0; r < m; r++ {
			if dp[r][c] == -1 { // If current cell is unreachable, skip
				continue
			}

			// Possible moves: (r-1, c+1), (r, c+1), (r+1, c+1)
			moves := []struct{ dr, dc int }{{-1, 1}, {0, 1}, {1, 1}}

			for _, move := range moves {
				nr, nc := r+move.dr, c+move.dc

				// Check bounds and if target is a pawn (grid[nr][nc] == 1)
				if nr >= 0 && nr < m && nc < n && grid[nr][nc] == 1 {
					// Update dp[nr][nc] with the maximum moves to reach it
					dp[nr][nc] = max(dp[nr][nc], dp[r][c]+1)
					maxTotalMoves = max(maxTotalMoves, dp[nr][nc])
				}
			}
		}
	}

	return maxTotalMoves
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}