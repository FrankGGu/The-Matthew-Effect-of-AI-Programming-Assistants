func solve(board [][]byte) {
    if len(board) == 0 || len(board[0]) == 0 {
        return
    }
    m, n := len(board), len(board[0])

    var dfs func(i, j int)
    dfs = func(i, j int) {
        if i < 0 || i >= m || j < 0 || j >= n || board[i][j] != 'O' {
            return
        }
        board[i][j] = '#'
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    }

    for i := 0; i < m; i++ {
        if board[i][0] == 'O' {
            dfs(i, 0)
        }
        if board[i][n-1] == 'O' {
            dfs(i, n-1)
        }
    }

    for j := 0; j < n; j++ {
        if board[0][j] == 'O' {
            dfs(0, j)
        }
        if board[m-1][j] == 'O' {
            dfs(m-1, j)
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == 'O' {
                board[i][j] = 'X'
            } else if board[i][j] == '#' {
                board[i][j] = 'O'
            }
        }
    }
}