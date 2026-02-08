package main

type trieNode struct {
	children [2]*trieNode
}

type trie struct {
	root    *trieNode
	maxBits int
}

func newTrie(maxBits int) *trie {
	return &trie{
		root:    &trieNode{},
		maxBits: maxBits,
	}
}

func (t *trie) insert(num int) {
	curr := t.root
	for i := t.maxBits; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &trieNode{}
		}
		curr = curr.children[bit]
	}
}

func (t *trie) findMaxXOR(num int) int {
	curr := t.root
	maxXOR := 0
	for i := t.maxBits; i >= 0; i-- {
		bit := (num >> i) & 1
		oppositeBit := 1 - bit

		if curr.children[oppositeBit] != nil {
			maxXOR |= (1 << i)
			curr = curr.children[oppositeBit]
		} else {
			curr = curr.children[bit]
		}
	}
	return maxXOR
}

func findMaximumXOR(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	t := newTrie(30) // Max bit position for numbers up to 2^31 - 1 is 30

	for _, num := range nums {
		t.insert(num)
	}

	maxGlobalXOR := 0
	for _, num := range nums {
		currentMaxXOR := t.findMaxXOR(num)
		if currentMaxXOR > maxGlobalXOR {
			maxGlobalXOR = currentMaxXOR
		}
	}

	return maxGlobalXOR
}