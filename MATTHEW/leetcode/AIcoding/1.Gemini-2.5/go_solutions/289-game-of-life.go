func gameOfLife(board [][]int) {
	m := len(board)
	if m == 0 {
		return
	}
	n := len(board[0])
	if n == 0 {
		return
	}

	dirs := [][]int{
		{-1, -1}, {-1, 0}, {-1, 1},
		{0, -1}, {0, 1},
		{1, -1}, {1, 0}, {1, 1},
	}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			liveNeighbors := 0
			for _, dir := range dirs {
				nr, nc := r+dir[0], c+dir[1]

				if nr >= 0 && nr < m && nc >= 0 && nc < n {
					// A cell is considered "live" for neighbor counting if its original state was 1.
					// This includes cells still alive (1) or cells that were alive but will die (2).
					if board[nr][nc] == 1 || board[nr][nc] == 2 {
						liveNeighbors++
					}
				}
			}

			if board[r][c] == 1 { // Current cell is live
				if liveNeighbors < 2 || liveNeighbors > 3 {
					board[r][c] = 2 // Mark as 1 -> 0 (live to dead)
				}
				// Else (liveNeighbors == 2 or 3), it stays live, no change needed (remains 1)
			} else { // Current cell is dead (0)
				if liveNeighbors == 3 {
					board[r][c] = 3 // Mark as 0 -> 1 (dead to live)
				}
				// Else, it stays dead, no change needed (remains 0)
			}
		}
	}

	// Final pass to convert temporary states to final states
	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			if board[r][c] == 2 { // Was 1, now 0
				board[r][c] = 0
			} else if board[r][c] == 3 { // Was 0, now 1
				board[r][c] = 1
			}
		}
	}
}