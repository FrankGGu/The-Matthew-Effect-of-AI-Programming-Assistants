func exist(board [][]byte, word string) bool {
    m, n := len(board), len(board[0])
    directions := [][]int{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}

    var dfs func(i, j, k int) bool
    dfs = func(i, j, k int) bool {
        if k == len(word) {
            return true
        }
        if i < 0 || i >= m || j < 0 || j >= n || board[i][j] != word[k] {
            return false
        }
        tmp := board[i][j]
        board[i][j] = '#'
        for _, dir := range directions {
            if dfs(i+dir[0], j+dir[1], k+1) {
                return true
            }
        }
        board[i][j] = tmp
        return false
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if dfs(i, j, 0) {
                return true
            }
        }
    }
    return false
}