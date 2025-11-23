type TrieNode struct {
    children [26]*TrieNode
    word     string
}

func findWords(board [][]byte, words []string) []string {
    root := &TrieNode{}
    for _, word := range words {
        node := root
        for _, c := range word {
            idx := c - 'a'
            if node.children[idx] == nil {
                node.children[idx] = &TrieNode{}
            }
            node = node.children[idx]
        }
        node.word = word
    }

    res := []string{}
    for i := 0; i < len(board); i++ {
        for j := 0; j < len(board[0]); j++ {
            dfs(board, i, j, root, &res)
        }
    }
    return res
}

func dfs(board [][]byte, i, j int, node *TrieNode, res *[]string) {
    c := board[i][j]
    if c == '#' || node.children[c-'a'] == nil {
        return
    }
    node = node.children[c-'a']
    if node.word != "" {
        *res = append(*res, node.word)
        node.word = ""
    }

    board[i][j] = '#'
    if i > 0 {
        dfs(board, i-1, j, node, res)
    }
    if j > 0 {
        dfs(board, i, j-1, node, res)
    }
    if i < len(board)-1 {
        dfs(board, i+1, j, node, res)
    }
    if j < len(board[0])-1 {
        dfs(board, i, j+1, node, res)
    }
    board[i][j] = c
}