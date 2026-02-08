func numRookCaptures(board [][]byte) int {
    directions := [][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    var rookX, rookY int

    for i := 0; i < 8; i++ {
        for j := 0; j < 8; j++ {
            if board[i][j] == 'R' {
                rookX, rookY = i, j
                break
            }
        }
    }

    captures := 0
    for _, dir := range directions {
        x, y := rookX, rookY
        for {
            x += dir[0]
            y += dir[1]
            if x < 0 || x >= 8 || y < 0 || y >= 8 {
                break
            }
            if board[x][y] == 'B' {
                break
            }
            if board[x][y] == 'p' {
                captures++
                break
            }
        }
    }

    return captures
}