type TrieNode struct {
    children map[byte]*TrieNode
    index    int
    length   int
}

type Trie struct {
    root *TrieNode
}

func NewTrie() *Trie {
    return &Trie{root: &TrieNode{children: make(map[byte]*TrieNode), index: -1, length: math.MaxInt32}}
}

func (t *Trie) Insert(word string, idx int) {
    node := t.root
    n := len(word)
    for i := n - 1; i >= 0; i-- {
        ch := word[i]
        if _, ok := node.children[ch]; !ok {
            node.children[ch] = &TrieNode{children: make(map[byte]*TrieNode), index: -1, length: math.MaxInt32}
        }
        node = node.children[ch]
        if n < node.length {
            node.length = n
            node.index = idx
        }
    }
}

func (t *Trie) Search(word string) int {
    node := t.root
    n := len(word)
    for i := n - 1; i >= 0; i-- {
        ch := word[i]
        if _, ok := node.children[ch]; !ok {
            break
        }
        node = node.children[ch]
    }
    return node.index
}

func stringIndices(wordsContainer []string, wordsQuery []string) []int {
    trie := NewTrie()
    for idx, word := range wordsContainer {
        trie.Insert(word, idx)
    }
    res := make([]int, len(wordsQuery))
    for i, word := range wordsQuery {
        res[i] = trie.Search(word)
    }
    return res
}