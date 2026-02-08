func gameOfLife(board [][]int) {
    rows := len(board)
    cols := len(board[0])

    directions := [][2]int{
        {-1, -1}, {-1, 0}, {-1, 1},
        {0, -1},          {0, 1},
        {1, -1}, {1, 0}, {1, 1},
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            liveNeighbors := 0
            for _, d := range directions {
                ni, nj := i + d[0], j + d[1]
                if ni >= 0 && ni < rows && nj >= 0 && nj < cols && (board[ni][nj] == 1 || board[ni][nj] == 2) {
                    liveNeighbors++
                }
            }
            if board[i][j] == 1 {
                if liveNeighbors < 2 || liveNeighbors > 3 {
                    board[i][j] = 1 // mark as dead
                } else {
                    board[i][j] = 3 // mark as alive to survive
                }
            } else {
                if liveNeighbors == 3 {
                    board[i][j] = 2 // mark as alive
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