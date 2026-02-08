func exist(board [][]byte, word string) bool {
    m, n := len(board), len(board[0])
    visited := make([][]bool, m)
    for i := range visited {
        visited[i] = make([]bool, n)
    }

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if dfs(board, word, i, j, 0, visited) {
                return true
            }
        }
    }
    return false
}

func dfs(board [][]byte, word string, i, j, index int, visited [][]bool) bool {
    if index == len(word) {
        return true
    }
    if i < 0 || i >= len(board) || j < 0 || j >= len(board[0]) || visited[i][j] || board[i][j] != word[index] {
        return false
    }

    visited[i][j] = true
    found := dfs(board, word, i+1, j, index+1, visited) ||
             dfs(board, word, i-1, j, index+1, visited) ||
             dfs(board, word, i, j+1, index+1, visited) ||
             dfs(board, word, i, j-1, index+1, visited)
    visited[i][j] = false
    return found
}