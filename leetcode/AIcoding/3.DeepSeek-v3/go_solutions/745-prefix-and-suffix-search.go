type WordFilter struct {
    prefixTrie *TrieNode
    suffixTrie *TrieNode
    wordIndex map[string]int
}

type TrieNode struct {
    children map[byte]*TrieNode
    indices  []int
}

func Constructor(words []string) WordFilter {
    prefixTrie := &TrieNode{children: make(map[byte]*TrieNode), indices: []int{}}
    suffixTrie := &TrieNode{children: make(map[byte]*TrieNode), indices: []int{}}
    wordIndex := make(map[string]int)

    for index, word := range words {
        wordIndex[word] = index
        insertIntoTrie(prefixTrie, word, index, false)
        insertIntoTrie(suffixTrie, reverseString(word), index, false)
    }

    return WordFilter{
        prefixTrie: prefixTrie,
        suffixTrie: suffixTrie,
        wordIndex: wordIndex,
    }
}

func insertIntoTrie(node *TrieNode, word string, index int, isSuffix bool) {
    for i := 0; i < len(word); i++ {
        ch := word[i]
        if _, ok := node.children[ch]; !ok {
            node.children[ch] = &TrieNode{children: make(map[byte]*TrieNode), indices: []int{}}
        }
        node = node.children[ch]
        node.indices = append(node.indices, index)
    }
}

func reverseString(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
    return string(runes)
}

func (this *WordFilter) F(prefix string, suffix string) int {
    prefixIndices := searchTrie(this.prefixTrie, prefix, false)
    suffixIndices := searchTrie(this.suffixTrie, reverseString(suffix), false)

    i, j := len(prefixIndices)-1, len(suffixIndices)-1
    for i >= 0 && j >= 0 {
        if prefixIndices[i] == suffixIndices[j] {
            return prefixIndices[i]
        } else if prefixIndices[i] > suffixIndices[j] {
            i--
        } else {
            j--
        }
    }
    return -1
}

func searchTrie(node *TrieNode, word string, isSuffix bool) []int {
    for i := 0; i < len(word); i++ {
        ch := word[i]
        if _, ok := node.children[ch]; !ok {
            return []int{}
        }
        node = node.children[ch]
    }
    return node.indices
}