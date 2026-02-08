func exist(board [][]byte, word string) bool {
    m := len(board)
    n := len(board[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    var dfs func(int, int, int) bool
    dfs = func(row, col, index int) bool {
        if index == len(word) {
            return true
        }

        if row < 0 || row >= m || col < 0 || col >= n || visited[row][col] || board[row][col] != word[index] {
            return false
        }

        visited[row][col] = true
        defer func() { visited[row][col] = false }()

        return dfs(row+1, col, index+1) ||
            dfs(row-1, col, index+1) ||
            dfs(row, col+1, index+1) ||
            dfs(row, col-1, index+1)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if board[i][j] == word[0] && dfs(i, j, 0) {
                return true
            }
        }
    }

    return false
}