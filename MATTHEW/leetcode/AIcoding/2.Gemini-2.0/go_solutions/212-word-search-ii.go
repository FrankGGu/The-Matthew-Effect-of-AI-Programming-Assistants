type TrieNode struct {
	children [26]*TrieNode
	word      string
}

func buildTrie(words []string) *TrieNode {
	root := &TrieNode{}
	for _, word := range words {
		node := root
		for _, char := range word {
			idx := char - 'a'
			if node.children[idx] == nil {
				node.children[idx] = &TrieNode{}
			}
			node = node.children[idx]
		}
		node.word = word
	}
	return root
}

func findWords(board [][]byte, words []string) []string {
	trie := buildTrie(words)
	rows := len(board)
	cols := len(board[0])
	result := make(map[string]bool)

	var dfs func(row, col int, node *TrieNode)
	dfs = func(row, col int, node *TrieNode) {
		if row < 0 || row >= rows || col < 0 || col >= cols || board[row][col] == '#' {
			return
		}

		char := board[row][col]
		idx := char - 'a'
		child := node.children[idx]
		if child == nil {
			return
		}

		if child.word != "" {
			result[child.word] = true
		}

		temp := board[row][col]
		board[row][col] = '#'

		dfs(row+1, col, child)
		dfs(row-1, col, child)
		dfs(row, col+1, child)
		dfs(row, col-1, child)

		board[row][col] = temp
	}

	for i := 0; i < rows; i++ {
		for j := 0; j < cols; j++ {
			dfs(i, j, trie)
		}
	}

	var res []string
	for word := range result {
		res = append(res, word)
	}
	return res
}