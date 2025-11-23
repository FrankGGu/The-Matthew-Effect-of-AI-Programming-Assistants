func placeWordInCrossword(board [][]byte, word string) bool {
    m, n := len(board), len(board[0])
    length := len(word)
    dirs := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == ' ' || board[i][j] == word[0] {
                for _, dir := range dirs {
                    x, y := i - dir[0], j - dir[1]
                    if x >= 0 && x < m && y >= 0 && y < n && board[x][y] != '#' {
                        continue
                    }
                    ni, nj := i, j
                    k := 0
                    for ; k < length; k++ {
                        if ni < 0 || ni >= m || nj < 0 || nj >= n {
                            break
                        }
                        if board[ni][nj] != ' ' && board[ni][nj] != word[k] {
                            break
                        }
                        ni += dir[0]
                        nj += dir[1]
                    }
                    if k == length {
                        if ni < 0 || ni >= m || nj < 0 || nj >= n || board[ni][nj] == '#' {
                            return true
                        }
                    }
                }
            }
        }
    }
    return false
}