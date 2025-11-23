type TrieNode struct {
    children map[rune]*TrieNode
    isEnd    bool
}

type WordDictionary struct {
    root *TrieNode
}

func Constructor() WordDictionary {
    return WordDictionary{root: &TrieNode{children: make(map[rune]*TrieNode)}}
}

func (wd *WordDictionary) AddWord(word string) {
    node := wd.root
    for _, ch := range word {
        if node.children[ch] == nil {
            node.children[ch] = &TrieNode{children: make(map[rune]*TrieNode)}
        }
        node = node.children[ch]
    }
    node.isEnd = true
}

func (wd *WordDictionary) Search(word string) bool {
    return wd.searchInNode(word, wd.root)
}

func (wd *WordDictionary) searchInNode(word string, node *TrieNode) bool {
    for i, ch := range word {
        if ch == '.' {
            for _, child := range node.children {
                if wd.searchInNode(word[i+1:], child) {
                    return true
                }
            }
            return false
        } else {
            if node.children[ch] == nil {
                return false
            }
            node = node.children[ch]
        }
    }
    return node.isEnd
}