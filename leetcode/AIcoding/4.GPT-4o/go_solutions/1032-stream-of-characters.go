type StreamChecker struct {
    trie    *TrieNode
    history []byte
}

type TrieNode struct {
    children [26]*TrieNode
    end      bool
}

func Constructor(words []string) StreamChecker {
    root := &TrieNode{}
    for _, word := range words {
        node := root
        for i := len(word) - 1; i >= 0; i-- {
            c := word[i] - 'a'
            if node.children[c] == nil {
                node.children[c] = &TrieNode{}
            }
            node = node.children[c]
        }
        node.end = true
    }
    return StreamChecker{trie: root, history: []byte{}}
}

func (this *StreamChecker) Query(letter byte) bool {
    this.history = append(this.history, letter)
    node := this.trie
    for i := len(this.history) - 1; i >= 0; i-- {
        c := this.history[i] - 'a'
        if node.children[c] == nil {
            return false
        }
        node = node.children[c]
        if node.end {
            return true
        }
    }
    return false
}