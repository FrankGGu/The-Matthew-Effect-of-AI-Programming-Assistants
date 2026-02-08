func checkMove(board [][]byte, r int, c int, color byte) bool {
    rows := len(board)
    cols := len(board[0])

    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

    for _, dir := range directions {
        dx, dy := dir[0], dir[1]
        x, y := r + dx, c + dy
        count := 0
        for x >= 0 && x < rows && y >= 0 && y < cols && board[x][y] != '.' {
            if board[x][y] != color {
                count++
            } else {
                if count >= 1 {
                    return true
                }
                break
            }
            x += dx
            y += dy
        }
    }

    return false
}