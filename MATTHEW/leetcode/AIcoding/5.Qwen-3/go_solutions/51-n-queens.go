package main

func solveNQueens(n int) [][]string {
    result := [][]string{}
    board := make([][]byte, n)
    for i := range board {
        board[i] = make([]byte, n)
        for j := range board[i] {
            board[i][j] = '.'
        }
    }
    backtrack(board, 0, &result)
    return result
}

func backtrack(board [][]byte, row int, result *[][]string) {
    if row == len(board) {
        var solution []string
        for _, row := range board {
            solution = append(solution, string(row))
        }
        *result = append(*result, solution)
        return
    }
    for col := 0; col < len(board); col++ {
        if isValid(board, row, col) {
            board[row][col] = 'Q'
            backtrack(board, row+1, result)
            board[row][col] = '.'
        }
    }
}

func isValid(board [][]byte, row, col int) bool {
    for i := 0; i < row; i++ {
        if board[i][col] == 'Q' {
            return false
        }
    }
    for i, j := row-1, col-1; i >= 0 && j >= 0; i, j = i-1, j-1 {
        if board[i][j] == 'Q' {
            return false
        }
    }
    for i, j := row-1, col+1; i >= 0 && j < len(board); i, j = i-1, j+1 {
        if board[i][j] == 'Q' {
            return false
        }
    }
    return true
}