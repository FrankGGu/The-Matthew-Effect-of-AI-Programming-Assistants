package main

import (
	"sort"
)

type TrieNode struct {
	children [2]*TrieNode
	count    int // Number of elements passing through this node
}

type Trie struct {
	root *TrieNode
}

func newTrie() *Trie {
	return &Trie{root: &TrieNode{}}
}

const MAX_BITS = 30

func (t *Trie) Insert(num int) {
	curr := t.root
	for i := MAX_BITS; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &TrieNode{}
		}
		curr = curr.children[bit]
		curr.count++
	}
}

func (t *Trie) Remove(num int) {
	curr := t.root
	for i := MAX_BITS; i >= 0; i-- {
		bit := (num >> i) & 1
		curr = curr.children[bit]
		curr.count--
	}
}

func (t *Trie) QueryMaxXOR(num int) int {
	curr := t.root
	maxXOR := 0
	for i := MAX_BITS; i >= 0; i-- {
		bit := (num >> i) & 1
		// Try to find the opposite bit to maximize XOR
		oppositeBit := 1 - bit
		if curr.children[oppositeBit] != nil && curr.children[oppositeBit].count > 0 {
			maxXOR |= (1 << i)
			curr = curr.children[oppositeBit]
		} else {
			// If opposite bit path doesn't exist or is empty, go with the same bit
			curr = curr.children[bit]
		}
	}
	return maxXOR
}

func maximumStrongPairXor(nums []int) int {
	sort.Ints(nums)

	max_xor := 0
	trie := newTrie()
	left := 0

	for right := 0; right < len(nums); right++ {
		// Maintain the sliding window [left, right] such that for any k in [left, right],
		// nums[k] and nums[right] form a strong pair.
		// The condition for a strong pair (x, y) with x >= y is x <= 2y.
		// Here, nums[right] is x, and nums[left] is y. So, nums[right] <= 2 * nums[left].
		// If 2 * nums[left] < nums[right], then nums[left] is too small to form a strong pair with nums[right].
		// So, remove nums[left] from the window.
		for left <= right && 2*nums[left] < nums[right] {
			trie.Remove(nums[left])
			left++
		}

		// Insert nums[right] into the Trie
		trie.Insert(nums[right])

		// Query for max XOR with nums[right] among numbers in the current window
		// (which are all in the Trie)
		current_max_xor := trie.QueryMaxXOR(nums[right])
		if current_max_xor > max_xor {
			max_xor = current_max_xor
		}
	}

	return max_xor
}