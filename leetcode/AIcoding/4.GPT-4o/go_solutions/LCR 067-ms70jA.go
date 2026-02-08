package main

import "fmt"

type TrieNode struct {
	children [2]*TrieNode
}

type Trie struct {
	root *TrieNode
}

func newTrie() *Trie {
	return &Trie{root: &TrieNode{}}
}

func (t *Trie) insert(num int) {
	node := t.root
	for i := 31; i >= 0; i-- {
		bit := (num >> i) & 1
		if node.children[bit] == nil {
			node.children[bit] = &TrieNode{}
		}
		node = node.children[bit]
	}
}

func (t *Trie) maxXor(num int) int {
	node := t.root
	maxXor := 0
	for i := 31; i >= 0; i-- {
		bit := (num >> i) & 1
		toggleBit := 1 - bit
		if node.children[toggleBit] != nil {
			maxXor |= (1 << i)
			node = node.children[toggleBit]
		} else {
			node = node.children[bit]
		}
	}
	return maxXor
}

func findMaximumXOR(nums []int) int {
	trie := newTrie()
	maxXor := 0
	for _, num := range nums {
		trie.insert(num)
	}
	for _, num := range nums {
		maxXor = max(maxXor, trie.maxXor(num))
	}
	return maxXor
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {
	nums := []int{3, 10, 5, 25, 2, 8}
	fmt.Println(findMaximumXOR(nums))
}