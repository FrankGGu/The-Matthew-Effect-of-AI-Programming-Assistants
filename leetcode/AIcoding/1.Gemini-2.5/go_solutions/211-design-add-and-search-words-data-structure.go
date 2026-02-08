type TrieNode struct {
	children [26]*TrieNode
	isEndOfWord bool
}

type WordDictionary struct {
	root *TrieNode
}

func Constructor() WordDictionary {
	return WordDictionary{root: &TrieNode{}}
}

func (this *WordDictionary) AddWord(word string) {
	node := this.root
	for _, char := range word {
		idx := char - 'a'
		if node.children[idx] == nil {
			node.children[idx] = &TrieNode{}
		}
		node = node.children[idx]
	}
	node.isEndOfWord = true
}

func (this *WordDictionary) Search(word string) bool {
	return this.dfs(this.root, word, 0)
}

func (this *WordDictionary) dfs(node *TrieNode, word string, index int) bool {
	if node == nil {
		return false
	}

	if index == len(word) {
		return node.isEndOfWord
	}

	char := word[index]

	if char == '.' {
		for i := 0; i < 26; i++ {
			if node.children[i] != nil {
				if this.dfs(node.children[i], word, index+1) {
					return true
				}
			}
		}
		return false
	} else {
		idx := char - 'a'
		if node.children[idx] == nil {
			return false
		}
		return this.dfs(node.children[idx], word, index+1)
	}
}