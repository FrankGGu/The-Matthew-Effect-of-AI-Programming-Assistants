func solveSudoku(board [][]byte) {
	backtrack(board)
}

func backtrack(board [][]byte) bool {
	for r := 0; r < 9; r++ {
		for c := 0; c < 9; c++ {
			if board[r][c] == '.' {
				for i := 1; i <= 9; i++ {
					char := byte(i + '0') // Convert int to byte character '1' through '9'
					if isValid(board, r, c, char) {
						board[r][c] = char
						if backtrack(board) { // Recursive call
							return true // Solution found
						}
						board[r][c] = '.' // Backtrack
					}
				}
				return false // No number worked for this cell, backtrack higher
			}
		}
	}
	return true // All cells filled, solution found
}

func isValid(board [][]byte, row, col int, char byte) bool {
	// Check row
	for c := 0; c < 9; c++ {
		if board[row][c] == char {
			return false
		}
	}

	// Check column
	for r := 0; r < 9; r++ {
		if board[r][col] == char {
			return false
		}
	}

	// Check 3x3 box
	startRow := (row / 3) * 3
	startCol := (col / 3) * 3
	for r := startRow; r < startRow+3; r++ {
		for c := startCol; c < startCol+3; c++ {
			if board[r][c] == char {
				return false
			}
		}
	}

	return true
}