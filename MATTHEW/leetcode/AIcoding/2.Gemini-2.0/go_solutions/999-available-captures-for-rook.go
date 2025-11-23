func numRookCaptures(board [][]byte) int {
	rookRow, rookCol := -1, -1
	for i := 0; i < 8; i++ {
		for j := 0; j < 8; j++ {
			if board[i][j] == 'R' {
				rookRow, rookCol = i, j
				break
			}
		}
		if rookRow != -1 {
			break
		}
	}

	captures := 0

	// Check up
	for i := rookRow - 1; i >= 0; i-- {
		if board[i][rookCol] == 'p' {
			captures++
			break
		} else if board[i][rookCol] == 'B' {
			break
		}
	}

	// Check down
	for i := rookRow + 1; i < 8; i++ {
		if board[i][rookCol] == 'p' {
			captures++
			break
		} else if board[i][rookCol] == 'B' {
			break
		}
	}

	// Check left
	for j := rookCol - 1; j >= 0; j-- {
		if board[rookRow][j] == 'p' {
			captures++
			break
		} else if board[rookRow][j] == 'B' {
			break
		}
	}

	// Check right
	for j := rookCol + 1; j < 8; j++ {
		if board[rookRow][j] == 'p' {
			captures++
			break
		} else if board[rookRow][j] == 'B' {
			break
		}
	}

	return captures
}