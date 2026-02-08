package main

func tictactoe(moves []int) string {
    board := [3][3]int{}
    for i, move := range moves {
        row, col := move/3, move%3
        if i%2 == 0 {
            board[row][col] = 1
        } else {
            board[row][col] = 2
        }
    }

    for player := 1; player <= 2; player++ {
        if (board[0][0] == player && board[0][1] == player && board[0][2] == player) ||
           (board[1][0] == player && board[1][1] == player && board[1][2] == player) ||
           (board[2][0] == player && board[2][1] == player && board[2][2] == player) ||
           (board[0][0] == player && board[1][0] == player && board[2][0] == player) ||
           (board[0][1] == player && board[1][1] == player && board[2][1] == player) ||
           (board[0][2] == player && board[1][2] == player && board[2][2] == player) ||
           (board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
           (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
            return "Player " + strconv.Itoa(player) + " wins"
        }
    }

    if len(moves) == 9 {
        return "Draw"
    }

    return "Pending"
}