func numRookCaptures(board [][]byte) int {
    var x, y int
    found := false
    for i := 0; i < 8; i++ {
        for j := 0; j < 8; j++ {
            if board[i][j] == 'R' {
                x, y = i, j
                found = true
                break
            }
        }
        if found {
            break
        }
    }

    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
    count := 0

    for _, dir := range directions {
        nx, ny := x + dir[0], y + dir[1]
        for nx >= 0 && nx < 8 && ny >= 0 && ny < 8 {
            if board[nx][ny] == 'B' {
                break
            }
            if board[nx][ny] == 'p' {
                count++
                break
            }
            nx += dir[0]
            ny += dir[1]
        }
    }

    return count
}