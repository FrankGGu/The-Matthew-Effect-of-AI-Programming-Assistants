type TrieNode struct {
    children map[rune]*TrieNode
    value    int
}

type MapSum struct {
    root *TrieNode
}

func Constructor() MapSum {
    return MapSum{root: &TrieNode{children: make(map[rune]*TrieNode)}}
}

func (this *MapSum) Insert(key string, val int) {
    node := this.root
    for _, ch := range key {
        if _, ok := node.children[ch]; !ok {
            node.children[ch] = &TrieNode{children: make(map[rune]*TrieNode)}
        }
        node = node.children[ch]
    }
    node.value = val
}

func (this *MapSum) Sum(prefix string) int {
    node := this.root
    for _, ch := range prefix {
        if _, ok := node.children[ch]; !ok {
            return 0
        }
        node = node.children[ch]
    }
    return this.dfs(node)
}

func (this *MapSum) dfs(node *TrieNode) int {
    sum := node.value
    for _, child := range node.children {
        sum += this.dfs(child)
    }
    return sum
}