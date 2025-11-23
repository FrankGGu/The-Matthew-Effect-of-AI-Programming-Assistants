func solveNQueens(n int) [][]string {
	var results [][]string
	board := make([]string, n)
	rowChars := make([]byte, n)
	for i := 0; i < n; i++ {
		rowChars[i] = '.'
	}

	colOccupied := make([]bool, n)
	diag1Occupied := make([]bool, 2*n-1) // r + c
	diag2Occupied := make([]bool, 2*n-1) // r - c + n - 1

	var backtrack func(row int)
	backtrack = func(row int) {
		if row == n {
			tempBoard := make([]string, n)
			copy(tempBoard, board)
			results = append(results, tempBoard)
			return
		}

		for col := 0; col < n; col++ {
			if !colOccupied[col] && !diag1Occupied[row+col] && !diag2Occupied[row-col+n-1] {
				// Place queen
				rowChars[col] = 'Q'
				board[row] = string(rowChars)
				colOccupied[col] = true
				diag1Occupied[row+col] = true
				diag2Occupied[row-col+n-1] = true

				backtrack(row + 1)

				// Backtrack
				rowChars[col] = '.'
				board[row] = string(rowChars)
				colOccupied[col] = false
				diag1Occupied[row+col] = false
				diag2Occupied[row-col+n-1] = false
			}
		}
	}

	backtrack(0)
	return results
}