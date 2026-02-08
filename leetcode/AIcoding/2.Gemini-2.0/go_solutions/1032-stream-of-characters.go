type TrieNode struct {
	children [26]*TrieNode
	isWord   bool
}

type StreamChecker struct {
	trie     *TrieNode
	stream   []byte
	maxLen   int
}

func Constructor(words []string) StreamChecker {
	trie := &TrieNode{}
	maxLen := 0
	for _, word := range words {
		curr := trie
		for i := len(word) - 1; i >= 0; i-- {
			char := word[i] - 'a'
			if curr.children[char] == nil {
				curr.children[char] = &TrieNode{}
			}
			curr = curr.children[char]
		}
		curr.isWord = true
		if len(word) > maxLen {
			maxLen = len(word)
		}
	}
	return StreamChecker{trie: trie, stream: []byte{}, maxLen: maxLen}
}

func (this *StreamChecker) Query(letter byte) bool {
	this.stream = append(this.stream, letter)
	if len(this.stream) > this.maxLen {
		this.stream = this.stream[len(this.stream)-this.maxLen:]
	}

	curr := this.trie
	for i := len(this.stream) - 1; i >= 0; i-- {
		char := this.stream[i] - 'a'
		if curr.children[char] == nil {
			return false
		}
		curr = curr.children[char]
		if curr.isWord {
			return true
		}
	}
	return false
}