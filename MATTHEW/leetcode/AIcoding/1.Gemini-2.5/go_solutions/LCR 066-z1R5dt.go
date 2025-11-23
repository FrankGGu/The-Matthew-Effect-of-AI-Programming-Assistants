type TrieNode struct {
	children map[rune]*TrieNode
	totalSum int
}

type MapSum struct {
	root      *TrieNode
	keyValues map[string]int
}

func newTrieNode() *TrieNode {
	return &TrieNode{
		children: make(map[rune]*TrieNode),
	}
}

func Constructor() MapSum {
	return MapSum{
		root:      newTrieNode(),
		keyValues: make(map[string]int),
	}
}

func (this *MapSum) Insert(key string, val int) {
	oldVal := this.keyValues[key]
	this.keyValues[key] = val
	diff := val - oldVal

	curr := this.root
	for _, r := range key {
		if _, ok := curr.children[r]; !ok {
			curr.children[r] = newTrieNode()
		}
		curr = curr.children[r]
		curr.totalSum += diff
	}
}

func (this *MapSum) Sum(prefix string) int {
	curr := this.root
	for _, r := range prefix {
		if _, ok := curr.children[r]; !ok {
			return 0
		}
		curr = curr.children[r]
	}
	return curr.totalSum
}