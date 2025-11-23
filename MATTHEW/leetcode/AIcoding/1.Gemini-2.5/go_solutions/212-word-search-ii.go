package main

type TrieNode struct {
	children [26]*TrieNode
	word     string
}

type Trie struct {
	root *TrieNode
}

func newTrie() *Trie {
	return &Trie{root: &TrieNode{}}
}

func (t *Trie) insert(word string) {
	node := t.root
	for _, char := range word {
		idx := char - 'a'
		if node.children[idx] == nil {
			node.children[idx] = &TrieNode{}
		}
		node = node.children[idx]
	}
	node.word = word
}

var (
	board [][]byte
	m, n  int
	res   []string
)

func findWords(b [][]byte, words []string) []string {
	board = b
	m = len(board)
	if m == 0 {
		return nil
	}
	n = len(board[0])
	if n == 0 {
		return nil
	}

	trie := newTrie()
	for _, word := range words {
		trie.insert(word)
	}

	res = []string{}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			dfs(r, c, trie.root)
		}
	}

	return res
}

func dfs(r, c int, parentNode *TrieNode) {
	if r < 0 || r >= m || c < 0 || c >= n {
		return
	}

	char := board[r][c]
	if char == '#' {
		return
	}

	charIdx := char - 'a'

	if parentNode.children[charIdx] == nil {
		return
	}

	currentNode := parentNode.children[charIdx]

	if currentNode.word != "" {
		res = append(res, currentNode.word)
		currentNode.word = ""
	}

	board[r][c] = '#'

	dfs(r+1, c, currentNode)
	dfs(r-1, c, currentNode)
	dfs(r, c+1, currentNode)
	dfs(r, c-1, currentNode)

	board[r][c] = char

	hasChildren := false
	for i := 0; i < 26; i++ {
		if currentNode.children[i] != nil {
			hasChildren = true
			break
		}
	}

	if !hasChildren && currentNode.word == "" {
		parentNode.children[charIdx] = nil
	}
}