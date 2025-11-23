package main

type TrieNode struct {
	children [26]*TrieNode
	count    int
}

func (t *TrieNode) insert(word string) {
	node := t
	for _, r := range word {
		idx := r - 'a'
		if node.children[idx] == nil {
			node.children[idx] = &TrieNode{}
		}
		node = node.children[idx]
		node.count++
	}
}

func sumPrefixScores(words []string) []int {
	root := &TrieNode{}
	for _, word := range words {
		root.insert(word)
	}

	scores := make([]int, len(words))
	for i, word := range words {
		currentScore := 0
		node := root
		for _, r := range word {
			idx := r - 'a'
			node = node.children[idx]
			currentScore += node.count
		}
		scores[i] = currentScore
	}

	return scores
}