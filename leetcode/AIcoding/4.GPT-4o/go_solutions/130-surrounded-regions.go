func solve(board [][]byte) {
    if len(board) == 0 || len(board[0]) == 0 {
        return
    }

    rows, cols := len(board), len(board[0])

    var dfs func(r, c int)
    dfs = func(r, c int) {
        if r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != 'O' {
            return
        }
        board[r][c] = 'E'
        dfs(r-1, c)
        dfs(r+1, c)
        dfs(r, c-1)
        dfs(r, c+1)
    }

    for r := 0; r < rows; r++ {
        if board[r][0] == 'O' {
            dfs(r, 0)
        }
        if board[r][cols-1] == 'O' {
            dfs(r, cols-1)
        }
    }

    for c := 0; c < cols; c++ {
        if board[0][c] == 'O' {
            dfs(0, c)
        }
        if board[rows-1][c] == 'O' {
            dfs(rows-1, c)
        }
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if board[r][c] == 'O' {
                board[r][c] = 'X'
            } else if board[r][c] == 'E' {
                board[r][c] = 'O'
            }
        }
    }
}