func checkMove(board [][]byte, rMove int, cMove int, color byte) bool {
    directions := [][]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    board[rMove][cMove] = color
    for _, dir := range directions {
        dr, dc := dir[0], dir[1]
        r, c := rMove + dr, cMove + dc
        length := 0
        for 0 <= r && r < 8 && 0 <= c && c < 8 {
            if board[r][c] == '.' {
                break
            }
            if board[r][c] == color {
                if length >= 1 {
                    return true
                }
                break
            }
            length++
            r += dr
            c += dc
        }
    }
    return false
}