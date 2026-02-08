import "fmt"

func alphabetBoardPath(target string) string {
	board := []string{"abcde", "fghij", "klmno", "pqrst", "uvwxyz"}
	res := ""
	currRow, currCol := 0, 0

	for _, char := range target {
		targetRow, targetCol := 0, 0
		for i := 0; i < len(board); i++ {
			for j := 0; j < len(board[i]); j++ {
				if rune(board[i][j]) == char {
					targetRow, targetCol = i, j
					break
				}
			}
		}

		rowDiff := targetRow - currRow
		colDiff := targetCol - currCol

		if rowDiff < 0 {
			for i := 0; i < -rowDiff; i++ {
				res += "U"
			}
		}
		if colDiff < 0 {
			for i := 0; i < -colDiff; i++ {
				res += "L"
			}
		}

		if colDiff > 0 {
			for i := 0; i < colDiff; i++ {
				res += "R"
			}
		}
		if rowDiff > 0 {
			for i := 0; i < rowDiff; i++ {
				res += "D"
			}
		}
		res += "!"

		currRow, currCol = targetRow, targetCol
	}

	return res
}