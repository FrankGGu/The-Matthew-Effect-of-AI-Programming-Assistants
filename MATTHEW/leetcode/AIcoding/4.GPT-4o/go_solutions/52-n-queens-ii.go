func totalNQueens(n int) int {
    return solveNQueens(0, n, 0, 0, 0)
}

func solveNQueens(row, n, cols, diags1, diags2 int) int {
    if row == n {
        return 1
    }
    count := 0
    for col := 0; col < n; col++ {
        bit := 1 << col
        if cols&bit == 0 && diags1&(1<<(row+col)) == 0 && diags2&(1<<(row-col+n-1)) == 0 {
            count += solveNQueens(row+1, n, cols|bit, diags1|(1<<(row+col)), diags2|(1<<(row-col+n-1)))
        }
    }
    return count
}