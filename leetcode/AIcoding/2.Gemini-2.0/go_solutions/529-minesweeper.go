func updateBoard(board [][]byte, click []int) [][]byte {
	x, y := click[0], click[1]
	if board[x][y] == 'M' {
		board[x][y] = 'X'
		return board
	}
	if board[x][y] == 'E' {
		reveal(board, x, y)
	}
	return board
}

func reveal(board [][]byte, x, y int) {
	if x < 0 || x >= len(board) || y < 0 || y >= len(board[0]) || board[x][y] != 'E' {
		return
	}

	count := countAdjacentMines(board, x, y)
	if count > 0 {
		board[x][y] = byte('0' + count)
		return
	}

	board[x][y] = 'B'
	reveal(board, x-1, y-1)
	reveal(board, x-1, y)
	reveal(board, x-1, y+1)
	reveal(board, x, y-1)
	reveal(board, x, y+1)
	reveal(board, x+1, y-1)
	reveal(board, x+1, y)
	reveal(board, x+1, y+1)
}

func countAdjacentMines(board [][]byte, x, y int) int {
	count := 0
	for i := x - 1; i <= x+1; i++ {
		for j := y - 1; j <= y+1; j++ {
			if i >= 0 && i < len(board) && j >= 0 && j < len(board[0]) && !(i == x && j == y) && board[i][j] == 'M' {
				count++
			}
		}
	}
	return count
}

func main() {}