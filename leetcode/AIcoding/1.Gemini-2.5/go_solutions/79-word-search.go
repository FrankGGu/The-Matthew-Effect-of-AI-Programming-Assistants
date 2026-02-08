func exist(board [][]byte, word string) bool {
    rows := len(board)
    if rows == 0 {
        return false
    }
    cols := len(board[0])

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if board[r][c] == word[0] {
                if dfs(board, word, r, c, 0) {
                    return true
                }
            }
        }
    }
    return false
}

func dfs(board [][]byte, word string, r, c, index int) bool {
    if index == len(word) {
        return true
    }

    rows := len(board)
    cols := len(board[0])

    if r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] != word[index] {
        return false
    }

    originalChar := board[r][c]
    board[r][c] = '#' // Mark as visited

    // Explore neighbors
    found := dfs(board, word, r+1, c, index+1) ||
             dfs(board, word, r-1, c, index+1) ||
             dfs(board, word, r, c+1, index+1) ||
             dfs(board, word, r, c-1, index+1)

    board[r][c] = originalChar // Backtrack: restore original character

    return found
}