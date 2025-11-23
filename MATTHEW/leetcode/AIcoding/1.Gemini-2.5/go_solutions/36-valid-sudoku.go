func isValidSudoku(board [][]byte) bool {
	rows := make([9][10]bool, 9)
	cols := make([9][10]bool, 9)
	boxes := make([9][10]bool, 9)

	for i := 0; i < 9; i++ {
		for j := 0; j < 9; j++ {
			char := board[i][j]
			if char == '.' {
				continue
			}

			digit := char - '0'
			boxIndex := (i/3)*3 + (j/3)

			if rows[i][digit] || cols[j][digit] || boxes[boxIndex][digit] {
				return false
			}

			rows[i][digit] = true
			cols[j][digit] = true
			boxes[boxIndex][digit] = true
		}
	}

	return true
}