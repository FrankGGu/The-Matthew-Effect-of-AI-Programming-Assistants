package main

func movesToChessboard(board [][]int) int {
    n := len(board)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if (board[i][j] + board[n-1-i][n-1-j]) != 1 {
                return -1
            }
            if (board[i][j] + board[i][n-1-j]) != 1 {
                return -1
            }
            if (board[i][j] + board[n-1-i][j]) != 1 {
                return -1
            }
        }
    }

    rowSwap, colSwap := 0, 0
    for i := 0; i < n; i++ {
        if board[0][i] != i%2 {
            rowSwap++
        }
        if board[i][0] != i%2 {
            colSwap++
        }
    }

    if n%2 == 1 {
        if rowSwap%2 == 1 {
            rowSwap = n - rowSwap
        }
        if colSwap%2 == 1 {
            colSwap = n - colSwap
        }
    } else {
        rowSwap = min(rowSwap, n - rowSwap)
        colSwap = min(colSwap, n - colSwap)
    }

    return (rowSwap + colSwap) / 2
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}