func solveNQueens(n int) [][]string {
    result := [][]string{}
    board := make([][]byte, n)
    for i := 0; i < n; i++ {
        board[i] = make([]byte, n)
        for j := 0; j < n; j++ {
            board[i][j] = '.'
        }
    }
    backtrack(&result, board, 0, n)
    return result
}

func backtrack(result *[][]string, board [][]byte, row, n int) {
    if row == n {
        temp := make([]string, n)
        for i := 0; i < n; i++ {
            temp[i] = string(board[i])
        }
        *result = append(*result, temp)
        return
    }
    for col := 0; col < n; col++ {
        if isValid(board, row, col, n) {
            board[row][col] = 'Q'
            backtrack(result, board, row+1, n)
            board[row][col] = '.'
        }
    }
}

func isValid(board [][]byte, row, col, n int) bool {
    for i := 0; i < row; i++ {
        if board[i][col] == 'Q' {
            return false
        }
        if col-(row-i) >= 0 && board[i][col-(row-i)] == 'Q' {
            return false
        }
        if col+(row-i) < n && board[i][col+(row-i)] == 'Q' {
            return false
        }
    }
    return true
}