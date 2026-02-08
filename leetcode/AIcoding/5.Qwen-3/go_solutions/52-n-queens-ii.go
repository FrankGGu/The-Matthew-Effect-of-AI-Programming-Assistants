package main

func totalNQueens(n int) int {
    result := 0
    board := make([]int, n)
    var backtrack func(int)
    backtrack = func(row int) {
        if row == n {
            result++
            return
        }
        for col := 0; col < n; col++ {
            if isValid(board, row, col) {
                board[row] = col
                backtrack(row + 1)
                board[row] = 0
            }
        }
    }
    backtrack(0)
    return result
}

func isValid(board []int, row, col int) bool {
    for i := 0; i < row; i++ {
        if board[i] == col || abs(i-row) == abs(board[i]-col) {
            return false
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}