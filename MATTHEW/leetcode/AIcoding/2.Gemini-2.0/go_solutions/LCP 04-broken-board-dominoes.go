func domino(m int, n int, broken []int) int {
	if m*n%2 != 0 {
		return 0
	}

	board := make([][]bool, m)
	for i := range board {
		board[i] = make([]bool, n)
	}

	for i := 0; i < len(broken); i += 2 {
		board[broken[i]][broken[i+1]] = true
	}

	count := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if !board[i][j] {
				if j+1 < n && !board[i][j+1] {
					count++
					board[i][j] = true
					board[i][j+1] = true
				} else if i+1 < m && !board[i+1][j] {
					count++
					board[i][j] = true
					board[i+1][j] = true
				}
			}
		}
	}

	return count
}