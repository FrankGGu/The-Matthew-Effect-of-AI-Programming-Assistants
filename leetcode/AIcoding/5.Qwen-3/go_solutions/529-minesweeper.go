package main

func updateBoard(board [][]byte, click []int) [][]byte {
    if board[click[0]][click[1]] == 'M' {
        board[click[0]][click[1]] = 'X'
        return board
    }
    dfs(board, click[0], click[1])
    return board
}

func dfs(board [][]byte, row, col int) {
    if row < 0 || col < 0 || row >= len(board) || col >= len(board[0]) || board[row][col] != 'E' {
        return
    }
    count := 0
    for i := -1; i <= 1; i++ {
        for j := -1; j <= 1; j++ {
            if i == 0 && j == 0 {
                continue
            }
            if row+i >= 0 && col+j >= 0 && row+i < len(board) && col+j < len(board[0]) && board[row+i][col+j] == 'M' {
                count++
            }
        }
    }
    if count > 0 {
        board[row][col] = byte('0' + count)
        return
    }
    board[row][col] = 'B'
    for i := -1; i <= 1; i++ {
        for j := -1; j <= 1; j++ {
            if i == 0 && j == 0 {
                continue
            }
            dfs(board, row+i, col+j)
        }
    }
}