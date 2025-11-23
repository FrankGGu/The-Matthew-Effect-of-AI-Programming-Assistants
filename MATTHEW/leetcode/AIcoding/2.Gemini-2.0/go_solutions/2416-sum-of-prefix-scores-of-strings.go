type TrieNode struct {
	children map[rune]*TrieNode
	score    int
}

type Trie struct {
	root *TrieNode
}

func Constructor() Trie {
	return Trie{
		root: &TrieNode{
			children: make(map[rune]*TrieNode),
			score:    0,
		},
	}
}

func (this *Trie) Insert(word string) {
	node := this.root
	for _, char := range word {
		if _, ok := node.children[char]; !ok {
			node.children[char] = &TrieNode{
				children: make(map[rune]*TrieNode),
				score:    0,
			}
		}
		node = node.children[char]
		node.score++
	}
}

func (this *Trie) SumPrefixScores(word string) int {
	node := this.root
	score := 0
	for _, char := range word {
		if _, ok := node.children[char]; !ok {
			return 0
		}
		node = node.children[char]
		score += node.score
	}
	return score
}

func sumPrefixScores(words []string) []int {
	trie := Constructor()
	for _, word := range words {
		trie.Insert(word)
	}

	result := make([]int, len(words))
	for i, word := range words {
		result[i] = trie.SumPrefixScores(word)
	}

	return result
}