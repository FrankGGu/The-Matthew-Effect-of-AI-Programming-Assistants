package main

type TrieNode struct {
    children [26]*TrieNode
    isEnd    bool
}

type Trie struct {
    root *TrieNode
}

func Constructor() Trie {
    return Trie{
        root: &TrieNode{},
    }
}

func (t *Trie) Insert(word string) {
    node := t.root
    for _, ch := range word {
        if node.children[ch-'a'] == nil {
            node.children[ch-'a'] = &TrieNode{}
        }
        node = node.children[ch-'a']
    }
    node.isEnd = true
}

func (t *Trie) Search(word string) bool {
    node := t.root
    for _, ch := range word {
        if node.children[ch-'a'] == nil {
            return false
        }
        node = node.children[ch-'a']
    }
    return node.isEnd
}

func (t *Trie) StartsWith(prefix string) bool {
    node := t.root
    for _, ch := range prefix {
        if node.children[ch-'a'] == nil {
            return false
        }
        node = node.children[ch-'a']
    }
    return true
}