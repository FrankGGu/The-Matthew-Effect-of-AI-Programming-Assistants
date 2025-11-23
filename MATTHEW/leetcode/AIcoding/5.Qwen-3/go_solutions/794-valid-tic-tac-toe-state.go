package main

func validTicTacToe(board []string) bool {
    countX := 0
    countO := 0
    for i := 0; i < 3; i++ {
        for j := 0; j < 3; j++ {
            if board[i][j] == 'X' {
                countX++
            } else if board[i][j] == 'O' {
                countO++
            }
        }
    }
    if countX != countO && countX != countO+1 {
        return false
    }
    winX := false
    winO := false
    for i := 0; i < 3; i++ {
        if board[i][0] == board[i][1] && board[i][1] == board[i][2] {
            if board[i][0] == 'X' {
                winX = true
            } else if board[i][0] == 'O' {
                winO = true
            }
        }
        if board[0][i] == board[1][i] && board[1][i] == board[2][i] {
            if board[0][i] == 'X' {
                winX = true
            } else if board[0][i] == 'O' {
                winO = true
            }
        }
    }
    if board[0][0] == board[1][1] && board[1][1] == board[2][2] {
        if board[0][0] == 'X' {
            winX = true
        } else if board[0][0] == 'O' {
            winO = true
        }
    }
    if board[0][2] == board[1][1] && board[1][1] == board[2][0] {
        if board[0][2] == 'X' {
            winX = true
        } else if board[0][2] == 'O' {
            winO = true
        }
    }
    if winX && winO {
        return false
    }
    if winX && countX != countO+1 {
        return false
    }
    if winO && countX != countO {
        return false
    }
    return true
}