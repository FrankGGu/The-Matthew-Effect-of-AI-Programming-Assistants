func placeWordInCrossword(board [][]byte, word string) bool {
    n, m := len(board), len(board[0])

    canPlace := func(x, y, dx, dy int) bool {
        for i := 0; i < len(word); i++ {
            if x < 0 || x >= n || y < 0 || y >= m {
                return false
            }
            if board[x][y] != ' ' && board[x][y] != word[i] {
                return false
            }
            x += dx
            y += dy
        }
        return (x < 0 || x >= n || y < 0 || y >= m || board[x][y] == '#') || (x >= 0 && x < n && y >= 0 && y < m && board[x][y] == ' ')
    }

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if board[i][j] == ' ' {
                if canPlace(i, j, 0, 1) || canPlace(i, j, 1, 0) {
                    return true
                }
            }
        }
    }
    return false
}