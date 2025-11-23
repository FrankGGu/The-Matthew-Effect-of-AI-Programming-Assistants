func countPrefixSuffixPairs(words []string) int64 {
	trie := &TrieNode{}
	count := int64(0)
	for _, w := range words {
		count += trie.AddAndCount(w)
	}
	return count
}

type TrieNode struct {
	Children [26]*TrieNode
	Count    int
}

func (t *TrieNode) AddAndCount(word string) int64 {
	count := int64(0)
	root := t
	for _, r := range word {
		root = t
		suffixCount := 0
		for j := 0; j < len(word); j++ {
			charIndex := word[j] - 'a'
			if root.Children[charIndex] == nil {
				root.Children[charIndex] = &TrieNode{}
			}
			root = root.Children[charIndex]
			if j <= len(word)-1 && word[:j+1] == word[len(word)-j-1:] {
				suffixCount += root.Count
			}
		}

		root = t
		for i := 0; i < len(word); i++ {
			charIndex := word[i] - 'a'
			if root.Children[charIndex] == nil {
				root.Children[charIndex] = &TrieNode{}
			}
			root = root.Children[charIndex]
		}

		root.Count++
		count += int64(suffixCount)
	}
	return count
}