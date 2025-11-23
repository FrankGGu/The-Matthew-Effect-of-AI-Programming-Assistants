func totalNQueens(n int) int {
    count := 0
    cols := make([]bool, n)
    diag1 := make([]bool, 2*n-1)
    diag2 := make([]bool, 2*n-1)

    var backtrack func(int)
    backtrack = func(row int) {
        if row == n {
            count++
            return
        }
        for col := 0; col < n; col++ {
            d1 := row - col + n - 1
            d2 := row + col
            if !cols[col] && !diag1[d1] && !diag2[d2] {
                cols[col], diag1[d1], diag2[d2] = true, true, true
                backtrack(row + 1)
                cols[col], diag1[d1], diag2[d2] = false, false, false
            }
        }
    }

    backtrack(0)
    return count
}