func exist(board [][]byte, word string) bool {
    rows := len(board)
    cols := len(board[0])
    wordLen := len(word)

    var dfs func(int, int, int) bool
    dfs = func(row, col, index int) bool {
        if index == wordLen {
            return true
        }

        if row < 0 || row >= rows || col < 0 || col >= cols || board[row][col] != word[index] {
            return false
        }

        temp := board[row][col]
        board[row][col] = ' ' 

        found := dfs(row+1, col, index+1) ||
                 dfs(row-1, col, index+1) ||
                 dfs(row, col+1, index+1) ||
                 dfs(row, col-1, index+1)

        board[row][col] = temp
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