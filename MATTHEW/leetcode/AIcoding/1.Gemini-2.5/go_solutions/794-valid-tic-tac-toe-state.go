func validTicTacToe(board []string) bool {
	xCount := 0
	oCount := 0

	for i := 0; i < 3; i++ {
		for j := 0; j < 3; j++ {
			if board[i][j] == 'X' {
				xCount++