type TrieNode struct {
	children    [26]*TrieNode
	isEndOfWord bool
}

type Trie struct {
	root *TrieNode
}

func Constructor() Trie {
	return Trie{
		root: &TrieNode{},
	}
}

func (this *Trie) Insert(word string) {
	curr := this.root
	for _, char := range word {
		idx := char - 'a'
		if curr.children[idx] == nil {
			curr.children[idx] = &TrieNode{}
		}
		curr = curr.children[idx]
	}
	curr.isEndOfWord = true
}

func (this *Trie) Search(word string) bool {
	curr := this.root
	for _, char := range word {
		idx := char - 'a'
		if curr.children[idx] == nil {
			return false
		}
		curr = curr.children[idx]
	}
	return curr.isEndOfWord
}

func (this *Trie) StartsWith(prefix string) bool {
	curr := this.root
	for _, char := range prefix {
		idx := char - 'a'
		if curr.children[idx] == nil {
			return false
		}
		curr = curr.children[idx]
	}
	return true
}