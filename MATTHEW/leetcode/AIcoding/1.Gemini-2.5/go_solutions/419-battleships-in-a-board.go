func countBattleships(board [][]byte) int {
	m := len(board)
	if m == 0 {
		return 0
	}
	n := len(board[0])
	if n == 0 {
		return 0
	}

	count := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if board[i][j] == 'X' {
				// Check if the cell above is 'X'. If so, this 'X' is part of an existing battleship.
				if i > 0 && board[i-1][j] == 'X' {
					continue
				}
				// Check if the cell to the left is 'X'. If so, this 'X' is part of an existing battleship.
				if j > 0 && board[i][j-1] == 'X' {
					continue
				}
				// If neither the cell above nor the cell to the left is 'X',
				// then this 'X' is the top-leftmost part of a new battleship.
				count++
			}
		}
	}
	return count
}