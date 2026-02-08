func exist(board [][]byte, word string) bool {
    rows := len(board)
    cols := len(board[0])

    var dfs func(i, j, index int) bool
    dfs = func(i, j, index int) bool {
        if index == len(word) {
            return true
        }
        if i < 0 || i >= rows || j < 0 || j >= cols || board[i][j] != word[index] {
            return false
        }

        temp := board[i][j]
        board[i][j] = '#'

        found := dfs(i+1, j, index+1) || dfs(i-1, j, index+1) ||
                 dfs(i, j+1, index+1) || dfs(i, j-1, index+1)

        board[i][j] = temp
        return found
    }

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            if dfs(i, j, 0) {
                return true
            }
        }
    }
    return false
}