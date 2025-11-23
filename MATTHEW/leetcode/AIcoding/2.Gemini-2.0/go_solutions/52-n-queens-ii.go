func totalNQueens(n int) int {
	count := 0
	board := make([]int, n)
	solveNQueens(board, 0, n, &count)
	return count
}

func solveNQueens(board []int, row int, n int, count *int) {
	if row == n {
		*count++
		return
	}

	for col := 0; col < n; col++ {
		if isSafe(board, row, col) {
			board[row] = col
			solveNQueens(board, row+1, n, count)
		}
	}
}

func isSafe(board []int, row int, col int) bool {
	for i := 0; i < row; i++ {
		if board[i] == col || abs(board[i]-col) == row-i {
			return false
		}
	}
	return true
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}