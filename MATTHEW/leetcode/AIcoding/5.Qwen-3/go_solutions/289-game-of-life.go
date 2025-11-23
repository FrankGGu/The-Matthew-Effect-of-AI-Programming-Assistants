package main

func gameOfLife(board [][]int) {
    if len(board) == 0 || len(board[0]) == 0 {
        return
    }
    rows, cols := len(board), len(board[0])
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            liveNeighbors := 0
            for x := -1; x <= 1; x++ {
                for y := -1; y <= 1; y++ {
                    if x == 0 && y == 0 {
                        continue
                    }
                    ni, nj := i+x, j+y
                    if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
                        liveNeighbors += board[ni][nj] & 1
                    }
                }
            }
            if board[i][j] == 1 {
                if liveNeighbors == 2 || liveNeighbors == 3 {
                    board[i][j] = 3 // 11 in binary, means alive and will stay alive
                }
            } else {
                if liveNeighbors == 3 {
                    board[i][j] = 2 // 10 in binary, means dead and will become alive
                }
            }
        }
    }
    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            board[i][j] >>= 1
        }
    }
}