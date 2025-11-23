type StreamChecker struct {
    root *TrieNode
    sb   []byte
}

type TrieNode struct {
    children [26]*TrieNode
    isEnd    bool
}

func Constructor(words []string) StreamChecker {
    root := &TrieNode{}
    for _, word := range words {
        node := root
        for i := len(word) - 1; i >= 0; i-- {
            idx := word[i] - 'a'
            if node.children[idx] == nil {
                node.children[idx] = &TrieNode{}
            }
            node = node.children[idx]
        }
        node.isEnd = true
    }
    return StreamChecker{root: root, sb: make([]byte, 0)}
}

func (this *StreamChecker) Query(letter byte) bool {
    this.sb = append(this.sb, letter)
    node := this.root
    for i := len(this.sb) - 1; i >= 0; i-- {
        idx := this.sb[i] - 'a'
        if node.children[idx] == nil {
            return false
        }
        node = node.children[idx]
        if node.isEnd {
            return true
        }
    }
    return false
}