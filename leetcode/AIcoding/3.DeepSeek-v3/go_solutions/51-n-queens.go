func solveNQueens(n int) [][]string {
    res := [][]string{}
    board := make([][]byte, n)
    for i := range board {
        board[i] = make([]byte, n)
        for j := range board[i] {
            board[i][j] = '.'
        }
    }

    cols := make([]bool, n)
    diag1 := make([]bool, 2*n-1)
    diag2 := make([]bool, 2*n-1)

    var backtrack func(int)
    backtrack = func(row int) {
        if row == n {
            tmp := make([]string, n)
            for i := range board {
                tmp[i] = string(board[i])
            }
            res = append(res, tmp)
            return
        }

        for col := 0; col < n; col++ {
            id1 := row - col + n - 1
            id2 := row + col
            if cols[col] || diag1[id1] || diag2[id2] {
                continue
            }
            board[row][col] = 'Q'
            cols[col], diag1[id1], diag2[id2] = true, true, true
            backtrack(row + 1)
            board[row][col] = '.'
            cols[col], diag1[id1], diag2[id2] = false, false, false
        }
    }

    backtrack(0)
    return res
}