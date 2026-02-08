func validTicTacToe(board []string) bool {
    xCount, oCount := 0, 0
    for _, row := range board {
        for _, c := range row {
            if c == 'X' {
                xCount++
            } else if c == 'O' {
                oCount++
            }
        }
    }
    if oCount != xCount && oCount != xCount-1 {
        return false
    }
    if win(board, 'X') && oCount != xCount-1 {
        return false
    }
    if win(board, 'O') && oCount != xCount {
        return false
    }
    return true
}

func win(board []string, p byte) bool {
    for i := 0; i < 3; i++ {
        if board[i][0] == p && board[i][1] == p && board[i][2] == p {
            return true
        }
        if board[0][i] == p && board[1][i] == p && board[2][i] == p {
            return true
        }
    }
    if board[0][0] == p && board[1][1] == p && board[2][2] == p {
        return true
    }
    if board[0][2] == p && board[1][1] == p && board[2][0] == p {
        return true
    }
    return false
}