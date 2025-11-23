package main

func findWords(board [][]byte, words []byte) []string {
	type node struct {
		children [26]*node
		word     string
	}
	root := &node{}
	for i := 0; i < len(words); i += 2 {
		word := string(words[i:i+2])
		curr := root
		for j := 0; j < len(word); j++ {
			c := word[j] - 'a'
			if curr.children[c] == nil {
				curr.children[c] = &node{}
			}
			curr = curr.children[c]
		}
		curr.word = word
	}
	var result []string
	visited := make([][]bool, len(board))
	for i := range visited {
		visited[i] = make([]bool, len(board[0]))
	}
	var dfs func(i, j int, curr *node)
	dfs = func(i, j int, curr *node) {
		c := board[i][j] - 'a'
		if curr.children[c] == nil {
			return
		}
		curr = curr.children[c]
		if curr.word != "" {
			result = append(result, curr.word)
			curr.word = ""
		}
		visited[i][j] = true
		if i > 0 && !visited[i-1][j] {
			dfs(i-1, j, curr)
		}
		if i < len(board)-1 && !visited[i+1][j] {
			dfs(i+1, j, curr)
		}
		if j > 0 && !visited[i][j-1] {
			dfs(i, j-1, curr)
		}
		if j < len(board[0])-1 && !visited[i][j+1] {
			dfs(i, j+1, curr)
		}
		visited[i][j] = false
	}
	for i := 0; i < len(board); i++ {
		for j := 0; j < len(board[0]); j++ {
			dfs(i, j, root)
		}
	}
	return result
}