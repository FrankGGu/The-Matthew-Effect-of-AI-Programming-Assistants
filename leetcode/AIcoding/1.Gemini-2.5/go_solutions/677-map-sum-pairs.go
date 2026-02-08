type TrieNode struct {
	children map[rune]*TrieNode
	sum      int
}

type MapSum struct {
	root       *TrieNode
	wordValues map[string]int
}

func Constructor() MapSum {
	return MapSum{
		root:       &TrieNode{children: make(map[rune]*TrieNode)},
		wordValues: make(map[string]int),
	}
}

func (this *MapSum) Insert(key string, val int) {
	oldVal := this.wordValues[key]
	this.wordValues[key] = val
	diff := val - oldVal

	curr := this.root
	for _, char := range key {
		if curr.children[char] == nil {
			curr.children[char] = &TrieNode{children: make(map[rune]*TrieNode)}
		}
		curr = curr.children[char]
		curr.sum += diff
	}
}

func (this *MapSum) Sum(prefix string) int {
	curr := this.root
	for _, char := range prefix {
		if curr.children[char] == nil {
			return 0
		}
		curr = curr.children[char]
	}
	return curr.sum
}