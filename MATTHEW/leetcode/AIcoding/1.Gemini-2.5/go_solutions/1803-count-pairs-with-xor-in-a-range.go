type TrieNode struct {
	children [2]*TrieNode
	count    int // Number of elements whose prefix goes through this node
}

type Trie struct {
	root    *TrieNode
	maxBits int // Maximum number of bits to consider, e.g., 20 for typical constraints
}

func