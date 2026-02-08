func movesToChessboard(board [][]int) int {
    n := len(board)
    rowCount, colCount := 0, 0
    rowSum, colSum := 0, 0
    for i := 0; i < n; i++ {
        rowCount += board[0][i]
        colCount += board[i][0]
        if board[0][i] == board[i][0] {
            rowSum++
        }
        if board[0][i] == board[n-1][i] {
            colSum++
        }
    }
    if rowCount != n/2 && rowCount != (n+1)/2 {
        return -1
    }
    if colCount != n/2 && colCount != (n+1)/2 {
        return -1
    }
    rowMoves := countMoves(board, true)
    colMoves := countMoves(board, false)
    if rowMoves < 0 || colMoves < 0 {
        return -1
    }
    return rowMoves + colMoves
}

func countMoves(board [][]int, isRow bool) int {
    n := len(board)
    target := 0
    if n%2 == 0 {
        target = n / 2
    } else {
        target = (n + 1) / 2
    }
    count := 0
    for i := 0; i < n; i++ {
        if isRow {
            if board[i][0] == (i % 2) {
                count++
            }
        } else {
            if board[0][i] == (i % 2) {
                count++
            }
        }
    }
    if count > target {
        return target*2 - count
    }
    return count
}