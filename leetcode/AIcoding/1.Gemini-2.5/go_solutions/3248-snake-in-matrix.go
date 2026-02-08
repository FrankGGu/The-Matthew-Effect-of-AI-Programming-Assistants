package main

func exist(board [][]byte, word string) bool {
	rows := len(board)
	if rows == 0 {
		return false
	}
	cols := len(board[0])
	if cols == 0 {
		return false
	}
	if len(word) == 0 {
		return true
	}

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if board[r][c] == word[0] {
				if dfs(board, word, r, c, 0, rows, cols) {
					return true
				}
			}
		}
	}
	return false
}

func dfs(board [][]byte, word string, r, c, k, rows, cols int) bool {
	if k == len(word) {
		return true
	}

	if r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[k] {
		return false
	}

	originalChar := board[r][c]
	board[r][c] = '#'

	found := dfs(board, word, r+1, c, k+1, rows, cols) ||
		dfs(board, word, r-1, c, k+1, rows, cols) ||
		dfs(board, word, r, c+1, k+1, rows, cols) ||
		dfs(board, word, r, c-1, k+1, rows, cols)

	board[r][c] = originalChar

	return found
}