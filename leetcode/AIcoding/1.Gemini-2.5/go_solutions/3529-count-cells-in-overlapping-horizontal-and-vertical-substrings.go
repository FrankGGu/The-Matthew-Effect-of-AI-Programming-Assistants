func countCells(board [][]byte) int {
	m := len(board)
	if m == 0 {
		return 0
	}
	n := len(board[0])
	if n == 0 {
		return 0
	}

	rowCounts := make([]int, m)
	colCounts := make([]int, n)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if board[i][j] == 'X' {
				rowCounts[i]++
				colCounts[j]++
			}
		}
	}

	count := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if board[i][j] == 'X' {
				if rowCounts[i] > 1 && colCounts[j] > 1 {
					count++
				}
			}
		}
	}

	return count
}