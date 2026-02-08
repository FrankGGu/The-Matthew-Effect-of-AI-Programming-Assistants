func gameOfLife(board [][]int) {
	m := len(board)
	n := len(board[0])

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			lives := 0
			for x := max(0, i-1); x <= min(m-1, i+1); x++ {
				for y := max(0, j-1); y <= min(n-1, j+1); y++ {
					if x == i && y == j {
						continue
					}
					if board[x][y] > 0 {
						lives++
					}
				}
			}

			if board[i][j] == 1 && (lives < 2 || lives > 3) {
				board[i][j] = -1
			} else if board[i][j] == 0 && lives == 3 {
				board[i][j] = 2
			}
		}
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if board[i][j] == -1 {
				board[i][j] = 0
			} else if board[i][j] == 2 {
				board[i][j] = 1
			}
		}
	}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}