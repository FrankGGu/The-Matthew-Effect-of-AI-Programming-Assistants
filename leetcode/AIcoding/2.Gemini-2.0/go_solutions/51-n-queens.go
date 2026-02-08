func solveNQueens(n int) [][]string {
	var result [][]string
	board := make([]string, n)
	for i := 0; i < n; i++ {
		board[i] = string(make([]byte, n))
		for j := 0; j < n; j++ {
			board[i] = board[i][:j] + "." + board[i][j+1:]
		}
	}

	var backtrack func(row int)
	backtrack = func(row int) {
		if row == n {
			temp := make([]string, n)
			copy(temp, board)
			result = append(result, temp)
			return
		}

		for col := 0; col < n; col++ {
			if isValid(board, row, col, n) {
				board[row] = board[row][:col] + "Q" + board[row][col+1:]
				backtrack(row + 1)
				board[row] = board[row][:col] + "." + board[row][col+1:]
			}
		}
	}

	backtrack(0)
	return result
}

func isValid(board []string, row int, col int, n int) bool {
	for i := 0; i < row; i++ {
		if board[i][col] == 'Q' {
			return false
		}
	}

	for i, j := row-1, col-1; i >= 0 && j >= 0; i, j = i-1, j-1 {
		if board[i][j] == 'Q' {
			return false
		}
	}

	for i, j := row-1, col+1; i >= 0 && j < n; i, j = i-1, j+1 {
		if board[i][j] == 'Q' {
			return false
		}
	}

	return true
}