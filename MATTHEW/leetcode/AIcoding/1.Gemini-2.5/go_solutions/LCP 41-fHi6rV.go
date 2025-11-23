func checkMove(board [][]byte, r int, c int, color byte) bool {
	m := len(board)
	n := len(board[0])

	if board[r][c] != '.' {
		return false
	}

	opponentColor := byte('X')
	if color == 'X' {
		opponentColor = 'O'
	}

	dr := []int{-1, -1, -1, 0, 0, 1, 1, 1}
	dc := []int{-1, 0, 1, -1, 1, -1, 0, 1}

	for i := 0; i < 8; i++ {
		currR, currC := r+dr[i], c+dc[i]

		foundOpponent := false

		for currR >= 0 && currR < m && currC >= 0 && currC < n {
			if board[currR][currC] == opponentColor {
				foundOpponent = true
				currR += dr[i]
				currC += dc[i]
			} else if board[currR][currC] == color {
				if foundOpponent {
					return true
				} else {
					break
				}
			} else {
				break
			}
		}
	}

	return false
}