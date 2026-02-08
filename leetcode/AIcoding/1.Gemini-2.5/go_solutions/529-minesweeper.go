func updateBoard(board [][]byte, click []int) [][]byte {
	m := len(board)
	n := len(board[0])
	r, c := click[0], click[1]

	// If the clicked cell is a mine, reveal it as 'X' and end the game.
	if board[r][c] == 'M' {
		board[r][c] = 'X'
		return board
	}

	// Directions for 8 neighbors
	dr := []int{-1, -1, -1, 0, 0, 1, 1, 1}
	dc := []int{-1, 0, 1, -1, 1, -1, 0, 1}

	// DFS function to reveal cells
	var dfs func(row, col int)
	dfs = func(row, col int) {
		// Base cases for recursion:
		// 1. Out of bounds
		// 2. Not an unrevealed empty cell ('E')
		if row < 0 || row >= m || col < 0 || col >= n || board[row][col] != 'E' {
			return
		}

		// Count adjacent mines
		mineCount := 0
		for i := 0; i < 8; i++ {
			nr, nc := row+dr[i], col+dc[i]
			if nr >= 0 && nr < m && nc >= 0 && nc < n && board[nr][nc] == 'M' {
				mineCount++
			}
		}

		if mineCount > 0 {
			// If there are adjacent mines, reveal the cell with the mine count
			board[row][col] = byte(mineCount + '0')
		} else {
			// If no adjacent mines, reveal as 'B' and recursively reveal neighbors
			board[row][col] = 'B'
			for i := 0; i < 8; i++ {
				nr, nc := row+dr[i], col+dc[i]
				dfs(nr, nc) // Recursively call DFS on neighbors
			}
		}
	}

	// Start DFS from the clicked cell
	dfs(r, c)

	return board
}