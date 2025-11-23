func tictactoe(moves [][]int) string {
	board := [3][3]int{}
	for i, move := range moves {
		row, col := move[0], move[1]
		if i%2 == 0 {
			board[row][col] = 1
		} else {
			board[row][col] = 2
		}
	}

	for i := 0; i < 3; i++ {
		if board[i][0] != 0 && board[i][0] == board[i][1] && board[i][1] == board[i][2] {
			if board[i][0] == 1 {
				return "A"
			} else {
				return "B"
			}
		}
		if board[0][i] != 0 && board[0][i] == board[1][i] && board[1][i] == board[2][i] {
			if board[0][i] == 1 {
				return "A"
			} else {
				return "B"
			}
		}
	}

	if board[0][0] != 0 && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
		if board[0][0] == 1 {
			return "A"
		} else {
			return "B"
		}
	}

	if board[0][2] != 0 && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
		if board[0][2] == 1 {
			return "A"
		} else {
			return "B"
		}
	}

	if len(moves) == 9 {
		return "Draw"
	}

	return "Pending"
}