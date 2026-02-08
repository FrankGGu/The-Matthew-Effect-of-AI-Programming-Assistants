func updateBoard(board [][]byte, click []int) [][]byte {
    if board[click[0]][click[1]] == 'M' {
        board[click[0]][click[1]] = 'X'
        return board
    }

    directions := [][2]int{{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}}

    var dfs func(int, int)
    dfs = func(x, y int) {
        if x < 0 || x >= len(board) || y < 0 || y >= len(board[0]) || board[x][y] != 'E' {
            return
        }

        mineCount := 0
        for _, dir := range directions {
            nx, ny := x + dir[0], y + dir[1]
            if nx >= 0 && nx < len(board) && ny >= 0 && ny < len(board[0]) && board[nx][ny] == 'M' {
                mineCount++
            }
        }

        if mineCount > 0 {
            board[x][y] = byte(mineCount + '0')
        } else {
            board[x][y] = 'B'
            for _, dir := range directions {
                dfs(x + dir[0], y + dir[1])
            }
        }
    }

    dfs(click[0], click[1])
    return board
}