type TrieNode struct {
    children map[rune]*TrieNode
    isEnd    bool
}

func NewTrieNode() *TrieNode {
    return &TrieNode{
        children: make(map[rune]*TrieNode),
        isEnd:    false,
    }
}

type WordDictionary struct {
    root *TrieNode
}

func Constructor() WordDictionary {
    return WordDictionary{
        root: NewTrieNode(),
    }
}

func (this *WordDictionary) AddWord(word string) {
    node := this.root
    for _, ch := range word {
        if _, ok := node.children[ch]; !ok {
            node.children[ch] = NewTrieNode()
        }
        node = node.children[ch]
    }
    node.isEnd = true
}

func (this *WordDictionary) Search(word string) bool {
    return this.searchHelper(word, 0, this.root)
}

func (this *WordDictionary) searchHelper(word string, index int, node *TrieNode) bool {
    if index == len(word) {
        return node.isEnd
    }
    ch := rune(word[index])
    if ch != '.' {
        if child, ok := node.children[ch]; ok {
            return this.searchHelper(word, index+1, child)
        }
        return false
    } else {
        for _, child := range node.children {
            if this.searchHelper(word, index+1, child) {
                return true
            }
        }
        return false
    }
}