func tictactoe(moves [][]int) string {
    board := [3][3]int{}
    for i, move := range moves {
        board[move[0]][move[1]] = i % 2 + 1
    }

    for i := 0; i < 3; i++ {
        if board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != 0 {
            if board[i][0] == 1 {
                return "A"
            }
            return "B"
        }
        if board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != 0 {
            if board[0][i] == 1 {
                return "A"
            }
            return "B"
        }
    }
    if board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0 {
        if board[0][0] == 1 {
            return "A"
        }
        return "B"
    }
    if board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0 {
        if board[0][2] == 1 {
            return "A"
        }
        return "B"
    }
    if len(moves) == 9 {
        return "Draw"
    }
    return "Pending"
}