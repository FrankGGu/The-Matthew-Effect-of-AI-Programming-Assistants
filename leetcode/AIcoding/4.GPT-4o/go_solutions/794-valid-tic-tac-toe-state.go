func validTicTacToe(board []string) bool {
    xCount, oCount := 0, 0
    for _, row := range board {
        for _, cell := range row {
            if cell == 'X' {
                xCount++
            } else if cell == 'O' {
                oCount++
            }
        }
    }

    if xCount < oCount || xCount > oCount + 1 {
        return false
    }

    xWin := win(board, 'X')
    oWin := win(board, 'O')

    if xWin && oWin {
        return false
    }
    if xWin && xCount == oCount {
        return false
    }
    if oWin && xCount > oCount {
        return false
    }

    return true
}

func win(board []string, player byte) bool {
    return (board[0][0] == player && board[0][1] == player && board[0][2] == player) ||
           (board[1][0] == player && board[1][1] == player && board[1][2] == player) ||
           (board[2][0] == player && board[2][1] == player && board[2][2] == player) ||
           (board[0][0] == player && board[1][0] == player && board[2][0] == player) ||
           (board[0][1] == player && board[1][1] == player && board[2][1] == player) ||
           (board[0][2] == player && board[1][2] == player && board[2][2] == player) ||
           (board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
           (board[0][2] == player && board[1][1] == player && board[2][0] == player)
}