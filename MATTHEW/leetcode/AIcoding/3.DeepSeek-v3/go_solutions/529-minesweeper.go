func updateBoard(board [][]byte, click []int) [][]byte {
    x, y := click[0], click[1]
    if board[x][y] == 'M' {
        board[x][y] = 'X'
        return board
    }
    m, n := len(board), len(board[0])
    dirs := [][]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}
    var dfs func(int, int)
    dfs = func(i, j int) {
        if i < 0 || i >= m || j < 0 || j >= n || board[i][j] != 'E' {
            return
        }
        mines := 0
        for _, d := range dirs {
            ni, nj := i+d[0], j+d[1]
            if ni >= 0 && ni < m && nj >= 0 && nj < n && board[ni][nj] == 'M' {
                mines++
            }
        }
        if mines > 0 {
            board[i][j] = byte('0' + mines)
        } else {
            board[i][j] = 'B'
            for _, d := range dirs {
                dfs(i+d[0], j+d[1])
            }
        }
    }
    dfs(x, y)
    return board
}