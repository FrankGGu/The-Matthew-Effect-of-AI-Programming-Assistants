func movesToChessboard(board [][]int) int {
    n := len(board)

    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if board[0][0]^board[i][0]^board[0][j]^board[i][j] != 0 {
                return -1
            }
        }
    }

    rowSum, colSum := 0, 0
    rowSwap, colSwap := 0, 0

    for i := 0; i < n; i++ {
        rowSum += board[0][i]
        colSum += board[i][0]
        if board[i][0] == i%2 {
            rowSwap++
        }
        if board[0][i] == i%2 {
            colSwap++
        }
    }

    if rowSum != n/2 && rowSum != (n+1)/2 {
        return -1
    }
    if colSum != n/2 && colSum != (n+1)/2 {
        return -1
    }

    if n%2 == 1 {
        if rowSwap%2 == 1 {
            rowSwap = n - rowSwap
        }
        if colSwap%2 == 1 {
            colSwap = n - colSwap
        }
    } else {
        rowSwap = min(rowSwap, n-rowSwap)
        colSwap = min(colSwap, n-colSwap)
    }

    return (rowSwap + colSwap) / 2
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}