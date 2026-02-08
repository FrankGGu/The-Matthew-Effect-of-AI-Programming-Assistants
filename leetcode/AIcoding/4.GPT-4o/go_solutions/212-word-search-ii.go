func findWords(board [][]byte, words []string) []string {
    trie := make(map[string]bool)
    for _, word := range words {
        trie[word] = true
    }
    res := make(map[string]bool)
    rows, cols := len(board), len(board[0])

    var dfs func(r, c int, node string, path string)
    dfs = func(r, c int, node string, path string) {
        if _, ok := trie[path]; ok {
            res[path] = true
        }
        if r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] == '#' {
            return
        }
        char := board[r][c]
        board[r][c] = '#'
        for _, dir := range []struct{ dr, dc int }{{1, 0}, {-1, 0}, {0, 1}, {0, -1}} {
            dfs(r+dir.dr, c+dir.dc, node, path+string(char))
        }
        board[r][c] = char
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            dfs(r, c, "", "")
        }
    }

    result := []string{}
    for k := range res {
        result = append(result, k)
    }
    return result
}