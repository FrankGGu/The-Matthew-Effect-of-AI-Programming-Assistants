func validTicTacToe(board []string) bool {
	xCount := 0
	oCount := 0
	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			if board[i][j] == 'X' {
				xCount++
			} else if board[i][j] == 'O' {
				oCount++
			}
		}
	}
	if oCount > xCount || xCount-oCount > 1 {
		return false
	}
	xWins := wins(board, 'X')
	oWins := wins(board, 'O')
	if xWins && oWins {
		return false
	}
	if xWins && xCount == oCount {
		return false
	}
	if oWins && xCount > oCount {
		return false
	}
	return true
}

func wins(board []string, player byte) bool {
	for i := 0; i < 3; i++ {
		if board[i][0] == player && board[i][1] == player && board[i][2] == player {
			return true
		}
		if board[0][i] == player && board[1][i] == player && board[2][i] == player {
			return true
		}
	}
	if board[0][0] == player && board[1][1] == player && board[2][2] == player {
		return true
	}
	if board[0][2] == player && board[1][1] == player && board[2][0] == player {
		return true
	}
	return false
}