func solveSudoku(board [][]byte) {
    var rows, cols, boxes [9][9]bool
    for i := 0; i < 9; i++ {
        for j := 0; j < 9; j++ {
            if board[i][j] != '.' {
                num := board[i][j] - '1'
                boxIdx := (i/3)*3 + j/3
                rows[i][num] = true
                cols[j][num] = true
                boxes[boxIdx][num] = true
            }
        }
    }
    var backtrack func(int, int) bool
    backtrack = func(row, col int) bool {
        if row == 9 {
            return true
        }
        if col == 9 {
            return backtrack(row+1, 0)
        }
        if board[row][col] != '.' {
            return backtrack(row, col+1)
        }
        boxIdx := (row/3)*3 + col/3
        for num := 0; num < 9; num++ {
            if !rows[row][num] && !cols[col][num] && !boxes[boxIdx][num] {
                board[row][col] = byte(num + '1')
                rows[row][num] = true
                cols[col][num] = true
                boxes[boxIdx][num] = true
                if backtrack(row, col+1) {
                    return true
                }
                board[row][col] = '.'
                rows[row][num] = false
                cols[col][num] = false
                boxes[boxIdx][num] = false
            }
        }
        return false
    }
    backtrack(0, 0)
}