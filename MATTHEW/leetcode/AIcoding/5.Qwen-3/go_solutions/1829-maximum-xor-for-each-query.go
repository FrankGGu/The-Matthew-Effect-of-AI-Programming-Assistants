package main

func maximizeXOR(a []int, queries [][]int) []int {
    sort.Slice(queries, func(i, j int) bool {
        return queries[i][1] < queries[j][1]
    })
    for i := range queries {
        queries[i] = append(queries[i], i)
    }
    trie := &Trie{}
    res := make([]int, len(queries))
    idx := 0
    for _, q := range queries {
        x, m, i := q[0], q[1], q[2]
        for idx < len(a) && a[idx] <= m {
            trie.insert(a[idx])
            idx++
        }
        res[i] = trie.getMaxXOR(x)
    }
    return res
}

type Trie struct {
    root *Node
}

type Node struct {
    children [2]*Node
}

func (t *Trie) insert(num int) {
    node := t.root
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &Node{}
        }
        node = node.children[bit]
    }
}

func (t *Trie) getMaxXOR(num int) int {
    if t.root == nil {
        return 0
    }
    node := t.root
    maxNum := 0
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        toggledBit := 1 - bit
        if node.children[toggledBit] != nil {
            maxNum |= (1 << i)
            node = node.children[toggledBit]
        } else {
            node = node.children[bit]
        }
    }
    return maxNum
}

func NewTrie() *Trie {
    return &Trie{
        root: &Node{},
    }
}