func solveSudoku(board [][]byte) {
    backtrack(board)
}

func backtrack(board [][]byte) bool {
    for i := 0; i < 9; i++ {
        for j := 0; j < 9; j++ {
            if board[i][j] == '.' {
                for num := '1'; num <= '9'; num++ {
                    if isValid(board, i, j, byte(num)) {
                        board[i][j] = byte(num)
                        if backtrack(board) {
                            return true
                        }
                        board[i][j] = '.'
                    }
                }
                return false
            }
        }
    }
    return true
}

func isValid(board [][]byte, row int, col int, num byte) bool {
    for i := 0; i < 9; i++ {
        if board[row][i] == num || board[i][col] == num || board[row/3*3+i/3][col/3*3+i%3] == num {
            return false
        }
    }
    return true
}