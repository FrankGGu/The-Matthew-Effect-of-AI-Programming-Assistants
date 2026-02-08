type Trie struct {
    children [26]*Trie
    isEnd    bool
}

func Constructor() Trie {
    return Trie{}
}

func (this *Trie) Insert(word string) {
    node := this
    for _, ch := range word {
        idx := ch - 'a'
        if node.children[idx] == nil {
            node.children[idx] = &Trie{}
        }
        node = node.children[idx]
    }
    node.isEnd = true
}

func (this *Trie) Search(word string) bool {
    node := this.searchPrefix(word)
    return node != nil && node.isEnd
}

func (this *Trie) StartsWith(prefix string) bool {
    node := this.searchPrefix(prefix)
    return node != nil
}

func (this *Trie) searchPrefix(prefix string) *Trie {
    node := this
    for _, ch := range prefix {
        idx := ch - 'a'
        if node.children[idx] == nil {
            return nil
        }
        node = node.children[idx]
    }
    return node
}