func gameOfLife(board [][]int)  {
    m, n := len(board), len(board[0])
    directions := [8][2]int{{-1,-1}, {-1,0}, {-1,1}, {0,-1}, {0,1}, {1,-1}, {1,0}, {1,1}}

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            live := 0
            for _, d := range directions {
                x, y := i + d[0], j + d[1]
                if x >= 0 && x < m && y >= 0 && y < n && (board[x][y] == 1 || board[x][y] == -1) {
                    live++
                }
            }
            if board[i][j] == 1 && (live < 2 || live > 3) {
                board[i][j] = -1
            }
            if board[i][j] == 0 && live == 3 {
                board[i][j] = 2
            }
        }
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == -1 {
                board[i][j] = 0
            } else if board[i][j] == 2 {
                board[i][j] = 1
            }
        }
    }
}