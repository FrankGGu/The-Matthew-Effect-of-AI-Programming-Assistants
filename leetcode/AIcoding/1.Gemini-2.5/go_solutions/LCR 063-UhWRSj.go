type TrieNode struct {
	children map[rune]*TrieNode // Map to store children nodes, keyed by character
	isEndOfWord bool           // True if this node marks the end of a root word
}