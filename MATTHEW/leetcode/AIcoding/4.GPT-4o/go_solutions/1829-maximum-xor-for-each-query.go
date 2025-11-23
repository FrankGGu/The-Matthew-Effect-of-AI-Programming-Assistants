package main

import (
    "sort"
)

type TrieNode struct {
    children [2]*TrieNode
    value    int
}

type Trie struct {
    root *TrieNode
}

func NewTrie() *Trie {
    return &Trie{root: &TrieNode{}}
}

func (t *Trie) Insert(num int) {
    node := t.root
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &TrieNode{}
        }
        node = node.children[bit]
    }
    node.value = num
}

func (t *Trie) MaxXOR(num int) int {
    node := t.root
    maxXOR := 0
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        oppositeBit := 1 - bit
        if node.children[oppositeBit] != nil {
            maxXOR |= (1 << i)
            node = node.children[oppositeBit]
        } else {
            node = node.children[bit]
        }
    }
    return maxXOR
}

func maximizeXor(nums []int, queries [][]int) []int {
    sort.Slice(queries, func(i, j int) bool {
        return queries[i][1] < queries[j][1]
    })

    n := len(nums)
    res := make([]int, len(queries))
    trie := NewTrie()
    j := 0

    for i := 0; i < len(queries); i++ {
        for j < n && nums[j] <= queries[i][1] {
            trie.Insert(nums[j])
            j++
        }
        if j == 0 {
            res[queries[i][2]] = -1
        } else {
            res[queries[i][2]] = trie.MaxXOR(queries[i][0])
        }
    }
    return res
}

func main() {
    // Example usage
    nums := []int{3, 1, 5, 6, 7}
    queries := [][]int{{3, 5}, {1, 2}, {2, 3}, {5, 6}}
    result := maximizeXor(nums, queries)
    fmt.Println(result)
}