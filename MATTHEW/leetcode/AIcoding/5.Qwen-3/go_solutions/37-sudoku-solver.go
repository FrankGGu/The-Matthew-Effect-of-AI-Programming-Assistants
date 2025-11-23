package main

func solveSudoku(board [][]byte) {
    solve(board)
}

func solve(board [][]byte) bool {
    for i := 0; i < 9; i++ {
        for j := 0; j < 9; j++ {
            if board[i][j] == '.' {
                for c := '1'; c <= '9'; c++ {
                    if isValid(board, i, j, byte(c)) {
                        board[i][j] = byte(c)
                        if solve(board) {
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
        if board[row][i] == num || board[i][col] == num {
            return false
        }
    }
    startRow, startCol := 3*(row/3), 3*(col/3)
    for i := 0; i < 3; i++ {
        for j := 0; j < 3; j++ {
            if board[startRow+i][startCol+j] == num {
                return false
            }
        }
    }
    return true
}